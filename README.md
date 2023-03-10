## Workflow to call MLST from uncorrected long reads using krocus.
### Usage

```

===============================================
 KROCUS TAPIR MLST Pipeline version ${version}
===============================================

Mandatory arguments:
         --reads                        Query fastqz file of sequences you wish to supply as input (e.g., "/MIGE/01_DATA/01_FASTQ/T055-8-*.fastq.gz")
         --mlst_database                MLST database directory (full path required, e.g., "/sw/mlst-master/db/pubmlst")
         --output_dir                   Output directory to place final combined krocus MLST output (e.g., "/MIGE/01_DATA/03_ASSEMBLY")
         --sequencing_date              Sequencing Date (for TAPIR, must start with G e.g., "G230223")
         --allele_dir                   Must be found within the mlst database directory (e.g., "efaecalis"). For TAPIR, this must be one of
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
        			 --kmer_size                    k-mer size (default: 11)
         			 --help                         This usage statement.
         			 --version                      Version statement


```


## Introduction
This pipeline predicts MLST from uncorrected long reads derived from pure cultures or metagenomic samples. This Nextflow pipeline was adapted from Andrew Page and other co-authors, and can be found [here](https://github.com/andrewjpage/krocus).

Inputs are fastqs specified using `--reads` and the species to which the sample reads belong specified using `--allele_dir`

## Sample command
An example of a command to run this pipeline for reads from Enterococcus faecalis is:

```
nextflow run main.nf --reads "PathToReadFiles" --output_dir "PathToOutputDir" --allele_dir "AlleleName" --sequencing_date "GYYMMDD" --mlst_database
"PathToMLSTDB"
```
