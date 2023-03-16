/*
 * pipeline input parameters
 */

params.reads = "$projectDir/data/ggal/gut_{1,2}.fastq"
params.output_dir = "$PWD/results"
params.kmer_size = 11
params.allele_dir = ""
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
    tag "error correction of $meta assemblies"
    
    publishDir "${params.output_dir}", mode:'copy'
    
    conda './env.yml'
    
    input:
    tuple val(meta), path(reads)
    val allele_dir
    val kmer_size

    output:
    path("*.krocus.txt")            , emit: indiv_krocus_ch
    path "versions.yml"             , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
    krocus /sw/mlst-master/db/pubmlst/${allele_dir} ${reads} -o ${prefix}.${allele_dir}.${kmer_size}.krocus.txt -k ${kmer_size}
    
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        krocus: \$( krocus --version 2>&1 )
    END_VERSIONS
    """
}

workflow  {
          read_ch = channel
                          .fromPath( params.reads, checkIfExists: true )
                          .map { file -> tuple(file.simpleName, file) }
			  
	  KROCUS(read_ch, params.allele_dir, params.kmer_size)

}
