#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// include definitions
include  { helpMessage; Version } from './messages.nf'

// include processes
include { KROCUS; COMBINE_KROCUS_FILES } from './processes.nf'


log.info """\
    ======================================
    KROCUS  - TAPIR MLST  P I P E L I N E
    ======================================
    output_dir      : ${params.output_dir}
    """
    .stripIndent()


workflow  {
          read_ch = channel
                          .fromPath( params.reads, checkIfExists: true )
                          .map { file -> tuple(file.simpleName, file) }

          KROCUS(read_ch, params.allele_dir, params.kmer_size, params.mlst_database)

          collected_krocus_ch = KROCUS.out.modified_krocus_ch.collect( sort: {a, b -> a[0].getBaseName() <=> b[0].getBaseName()} )

          COMBINE_KROCUS_FILES(collected_krocus_ch, params.allele_dir, params.sequencing_date, params.kmer_size)
}
