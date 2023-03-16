def help_message() {
  log.info """
        Usage:
        The typical command for running the pipeline is as follows:
        nextflow run main.nf --reads "PathToReadFile(s)" --output_dir "PathToOutputDir" --mlst_species "AlleleName" --sequencing_date "GYYMMDD" --mlst_database "PathToMLSTDB"

        Mandatory arguments:
         --reads                        Query fastqz file of sequences you wish to supply as input (e.g., "/MIGE/01_DATA/01_FASTQ/T055-8-*.fastq.gz")
         --mlst_database                MLST database directory (full path required, e.g., "/sw/mlst-master/db/pubmlst")
         --output_dir                   Output directory to place final combined krocus MLST output (e.g., "/MIGE/01_DATA/03_ASSEMBLY")
         --sequencing_date              Sequencing Date (for TAPIR, must start with G e.g., "G230223")
	 --kmer_size                    k-mer size (e.g., 11)
         --mlst_species                 Must be found within the mlst database directory (e.g., "efaecalis"). This must be one of
                                                abaumannii
                                                abaumannii_2
                                                achromobacter
                                                aeromonas
                                                afumigatus
                                                aphagocytophilum
                                                arcobacter
                                                bbacilliformis
                                                bcereus
                                                bhenselae
                                                bintermedia
                                                bordetella
                                                bpilosicoli
                                                brachyspira
                                                bsubtilis
                                                bcc
                                                bhampsonii
                                                bhyodysenteriae
                                                blicheniformis
                                                borrelia
                                                bpseudomallei
                                                brucella
						calbicans
                                                cconcisus
                                                cfetus
                                                chelveticus
                                                cinsulaenigrae
                                                clari
                                                csepticum
                                                ctropicalis
                                                campylobacter
                                                cdifficile
                                                cfreundii
                                                chlamydiales
                                                ckrusei
                                                cmaltaromaticum
                                                csinensis
                                                cupsaliensis
                                                cbotulinum
                                                cdiphtheriae
                                                cglabrata
                                                chyointestinalis
                                                clanienae
                                                cronobacter
                                                csputorum
                                                ctropicalis
                                                cupsaliensis
                                                dnodosus
                                                ecloacae
                                                ecoli
                                                ecoli_2
                                                edwardsiella
                                                efaecalis
                                                efaecium
                                                fpsychrophilum
                                                hcinaedi
                                                hinfluenzae
						hparasuis
                                                hpylori
                                                hsuis
                                                kaerogenes
                                                kkingae
                                                koxytoca
                                                kpneumoniae
                                                kseptempunctata
                                                legionella_sbt
                                                leptospira
                                                leptospira_2
                                                leptospira_3
                                                lmonocytogenes
                                                lsalivarius
                                                mabscessus
                                                magalactiae
                                                mbovis
                                                mcanis
                                                mcaseolyticus
                                                mcatarrhalis
                                                mhaemolytica
                                                mhyopneumoniae
                                                mhyorhinis
                                                miowae
                                                mmassiliense
                                                mplutonius
                                                mpneumoniae
                                                msynoviae
                                                neisseria
                                                orhinotracheale
                                                otsutsugamushi
                                                pacnes
                                                paeruginosa
                                                pdamselae
                                                pfluorescens
                                                pgingivalis
                                                plarvae
                                                pmultocida_multihost
						pmultocida_rirdc
                                                ppentosaceus
                                                ranatipestifer
                                                sagalactiae
                                                saureus
                                                sbsec
                                                scanis
                                                sdysgalactiae
                                                senterica
                                                sepidermidis
                                                sgallolyticus
                                                shaemolyticus
                                                shominis
                                                sinorhizobium
                                                slugdunensis
                                                smaltophilia
                                                soralis
                                                spneumoniae
                                                spseudintermedius
                                                spyogenes
                                                ssuis
                                                sthermophilus
                                                sthermophilus_2
                                                streptomyces
                                                suberis
                                                szooepidemicus
                                                taylorella
                                                tenacibaculum
                                                tvaginalis
                                                vcholerae
                                                vibrio
                                                vparahaemolyticus
                                                vtapetis
                                                vvulnificus
                                                wolbachia
                                                xfastidiosa
                                                yersinia
                                                ypseudotuberculosis
						yruckeri
						
	
        Optional arguments:
         --help                         This usage statement.
         --version                      Version statement
        """
}


def version_message(String version) {
      println(
            """
            ===============================================
             KROCUS TAPIR MLST Pipeline version ${version}
            ===============================================
            """.stripIndent()
        )

}


def pipeline_start_message(String version, Map params){
    log.info "======================================================================"
    log.info "                  KROCUS TAPIR MLST Pipeline version ${version}"
    log.info "======================================================================"
    log.info "Running version   : ${version}"
    log.info "Fastq inputs      : ${params.reads}"
    log.info ""
    log.info "-------------------------- Other parameters --------------------------"
    params.sort{ it.key }.each{ k, v ->
        if (v){
            log.info "${k}: ${v}"
        }
    }
    log.info "======================================================================"
    log.info "Outputs written to path '${params.output_dir}'"
    log.info "======================================================================"
    
    log.info ""
}


def complete_message(Map params, nextflow.script.WorkflowMetadata workflow, String version){
    // Display complete message
    log.info ""
    log.info "Ran the workflow: ${workflow.scriptName} ${version}"
    log.info "Command line    : ${workflow.commandLine}"
    log.info "Completed at    : ${workflow.complete}"
    log.info "Duration        : ${workflow.duration}"
    log.info "Success         : ${workflow.success}"
    log.info "Work directory  : ${workflow.workDir}"
    log.info "Exit status     : ${workflow.exitStatus}"
    log.info ""
}

def error_message(nextflow.script.WorkflowMetadata workflow){
    // Display error message
    log.info ""
    log.info "Workflow execution stopped with the following message:"
    log.info "  " + workflow.errorMessage
}
