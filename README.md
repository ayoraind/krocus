## Workflow to call MLST from uncorrected long reads using krocus.
### Usage

```

===============================================
 KROCUS TAPIR MLST Pipeline version 1.0dev
===============================================

Mandatory arguments:
         --reads                        Query fastq.gz file of sequences you wish to supply as input (e.g., "/MIGE/01_DATA/01_FASTQ/T055-8-*.fastq.gz")
         --mlst_database                MLST database directory (e.g., "/sw/mlst-master/db/pubmlst")
         --output_dir                   Output directory to place final combined krocus MLST output (e.g., "/MIGE/01_DATA/03_ASSEMBLY")
         --sequencing_date              Sequencing Date (for TAPIR, must start with G e.g., "G230223")
	 --kmer_size                    k-mer size (e.g., 11)
         --mlst_species                 Must be found within the mlst database directory (e.g., "efaecalis"). For TAPIR, this must be one of
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


```


## Introduction
This pipeline predicts MLST from uncorrected long reads derived from pure cultures or metagenomic samples. This Nextflow pipeline was adapted from Andrew Page's [Github page](https://github.com/andrewjpage/krocus), the original author of the Krocus tool. Follow the instructions in his Github [Usage](https://github.com/andrewjpage/krocus#usage) section to download relevant MLST databases into a suitable database directory. I refer to the database in the example code as "pubmlst".


Inputs are fastqs specified using `--reads`. The species to which the sample reads belong are specified using `--mlst_species`.


## Sample command
An example of a command to run this pipeline for reads from Enterococcus faecalis is:

```
nextflow run main.nf --reads "Sample_files/Sample-8-*.fastq.gz" --output_dir "test" --mlst_species "efaecalis" --sequencing_date "G230202" --mlst_database "pubmlst" --kmer_size 11
```

If this is to be done for multiple species, a for loop will be useful. An example can be found below:

```
for name in ecoli saureus shaemolyticus kaerogenes sepidermidis koxytoca efaecalis ecloacae shominis kpneumoniae paeruginosa slugdunensis neisseria
do

nextflow run main.nf --reads "*.fastq.gz" --output_dir "out_dir" --mlst_species "${name}" --sequencing_date "G230202" --mlst_database "pubmlst" --kmer_size 11 -w /path/to/work

done
```

## Word of Note
This is an ongoing project at the Microbial Genome Analysis Group, Institute for Infection Prevention and Hospital Epidemiology, Üniversitätsklinikum, Freiburg. The project is funded by BMBF, Germany, and is led by [Dr. Sandra Reuter](https://www.uniklinik-freiburg.de/institute-for-infection-prevention-and-control/microbial-genome-analysis.html).


## Authors and acknowledgment
The TAPIR (Track Acquisition of Pathogens In Real-time) team.
