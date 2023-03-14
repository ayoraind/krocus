process KROCUS {
    tag "${allele_dir} mlst from $meta reads"

   // publishDir "${params.output_dir}", mode:'copy'

    conda '/MIGE/01_DATA/07_TOOLS_AND_SOFTWARE/nextflow_pipelines/krocus/krocus_env.yml'

    input:
    tuple val(meta), path(reads)
    val allele_dir
    val kmer_size
    path db
    
    output:
    path("*.krocus.txt")            , emit: indiv_krocus_ch
    path("*.krocus.mod.txt")        , emit: modified_krocus_ch
    path "versions.yml"             , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
    krocus ${db}/${allele_dir} ${reads} -o ${prefix}.${allele_dir}.${kmer_size}mer.krocus.txt -k ${kmer_size}

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
