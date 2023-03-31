/*
 * pipeline input parameters
 */

params.reads = "$projectDir/data/ggal/gut_{1,2}.fastq"
params.output_dir = "$PWD/results"
params.kmer_size = 11
params.allele_dir = ""
params.sequencing_date = "GYYMMDD"
nextflow.enable.dsl=2


log.info """\
    KROCUS  - TAPIR   P I P E L I N E
    ============================================
    output_dir       : ${params.output_dir}
    """
    .stripIndent()

/*
 * define the `index` process that creates a binary index
 * given the transcriptome file
 */


process KROCUS {
    tag "${allele_dir} mlst from $meta reads"
    
   // publishDir "${params.output_dir}", mode:'copy'
    
    conda './krocus_env.yml'
    
    input:
    tuple val(meta), path(reads)
    val allele_dir
    val kmer_size

    output:
    path("*.krocus.txt")            , emit: indiv_krocus_ch
    path("*.krocus.mod.txt")	    , emit: modified_krocus_ch
    path "versions.yml"             , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
    krocus /sw/mlst-master/db/pubmlst/${allele_dir} ${reads} -o ${prefix}.${allele_dir}.${kmer_size}mer.krocus.txt -k ${kmer_size}
    
    krocus_modify.sh ${prefix}.${allele_dir}.${kmer_size}mer.krocus.txt > ${prefix}.${allele_dir}.${kmer_size}mer.krocus.mod.txt
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        krocus: \$( krocus --version 2>&1 )
    END_VERSIONS
    """
}

process COMBINE_KROCUS_FILES {
    publishDir "${params.output_dir}", mode:'copy'
    
    input:
    path(krocus_modified_individual_files)
    val allele_dir
    val date
    val kmer_size


    output:
    path("combined_krocus_${allele_dir}_${kmer_size}mer_${date}.txt"), emit: krocus_comb_ch


    script:
    """
    KROCUS_FILES=(${krocus_modified_individual_files})

    for index in \${!KROCUS_FILES[@]}; do
    KROCUS_FILE=\${KROCUS_FILES[\$index]}

    awk -F '\\t' 'FNR>=1 { print FILENAME, \$0 }' \${KROCUS_FILE} | sed 's/\\.${allele_dir}\\.${kmer_size}mer\\.krocus\\.mod\\.txt//g' >> combined_krocus_${allele_dir}_${kmer_size}mer_${date}.txt
    
        
    done
    """
}

workflow  {
          read_ch = channel
                          .fromPath( params.reads, checkIfExists: true )
                          .map { file -> tuple(file.simpleName, file) }
			  
	  KROCUS(read_ch, params.allele_dir, params.kmer_size)
	  
	  collected_krocus_ch = KROCUS.out.modified_krocus_ch.collect( sort: {a, b -> a[0].getBaseName() <=> b[0].getBaseName()} )
	 
          COMBINE_KROCUS_FILES(collected_krocus_ch, params.allele_dir, params.sequencing_date, params.kmer_size)
}
