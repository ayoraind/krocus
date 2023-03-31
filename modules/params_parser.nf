include { check_mandatory_parameter; check_optional_parameters; check_parameter_value } from './params_utilities.nf'

def default_params(){
    /***************** Setup inputs and channels ************************/
    def params = [:] as nextflow.script.ScriptBinding$ParamsMap
    // Defaults for configurable variables
    params.help = false
    params.version = false
    params.reads = false
    params.kmer_size = false
    params.sequencing_date = false
    params.mlst_species = false
    params.mlst_database = false
    params.output_dir = false
    return params
}

def check_params(Map params) { 
    final_params = params
    
    // set up reads files
    final_params.reads = check_mandatory_parameter(params, 'reads')
     
    // set up output directory
    final_params.output_dir = check_mandatory_parameter(params, 'output_dir') - ~/\/$/
     
    // set up kmer size
    final_params.kmer_size = check_mandatory_parameter(params, 'kmer_size')
    
    // set up sequencing date
    final_params.sequencing_date = check_mandatory_parameter(params, 'sequencing_date')
	
    // set up mlst database
    final_params.mlst_database = check_mandatory_parameter(params, 'mlst_database') - ~/\/$/
    
    // set up species
    final_params.mlst_species = check_mandatory_parameter(params, 'mlst_species')
    
    // check species is valid
    final_params.mlst_species = check_parameter_value('species', final_params.mlst_species, ['abaumannii', 'abaumannii_2', 'achromobacter', 'aeromonas', 'afumigatus', 'aphagocytophilum', 'arcobacter', 'bbacilliformis', 'bcereus', 'bhenselae', 'bintermedia', 'bordetella', 'bpilosicoli', 'brachyspira', 'bsubtilis', 'bcc', 'bhampsonii', 'bhyodysenteriae', 'blicheniformis', 'borrelia', 'bpseudomallei', 'brucella', 'calbicans', 'cconcisus', 'cfetus', 'chelveticus', 'cinsulaenigrae', 'clari', 'csepticum', 'ctropicalis', 'campylobacter', 'cdifficile', 'cfreundii', 'chlamydiales', 'ckrusei', 'cmaltaromaticum', 'csinensis', 'cupsaliensis', 'cbotulinum', 'cdiphtheriae', 'cglabrata', 'chyointestinalis', 'clanienae', 'cronobacter', 'csputorum', 'ctropicalis', 'cupsaliensis', 'dnodosus', 'ecloacae', 'ecoli', 'ecoli_2', 'edwardsiella', 'efaecalis', 'efaecium', 'fpsychrophilum', 'hcinaedi', 'hinfluenzae', 'hparasuis', 'hpylori', 'hsuis', 'kaerogenes', 'kkingae', 'koxytoca', 'kpneumoniae', 'kseptempunctata', 'legionella_sbt', 'leptospira', 'leptospira_2', 'leptospira_3', 'lmonocytogenes', 'lsalivarius', 'mabscessus', 'magalactiae', 'mbovis', 'mcanis', 'mcaseolyticus', 'mcatarrhalis', 'mhaemolytica', 'mhyopneumoniae', 'mhyorhinis', 'miowae', 'mmassiliense', 'mplutonius', 'mpneumoniae', 'msynoviae', 'neisseria', 'orhinotracheale', 'otsutsugamushi', 'pacnes', 'paeruginosa', 'pdamselae', 'pfluorescens', 'pgingivalis', 'plarvae', 'pmultocida_multihost', 'pmultocida_rirdc', 'ppentosaceus', 'ranatipestifer', 'sagalactiae', 'saureus', 'sbsec', 'scanis', 'sdysgalactiae', 'senterica', 'sepidermidis', 'sgallolyticus', 'shaemolyticus', 'shominis', 'sinorhizobium', 'slugdunensis', 'smaltophilia', 'soralis', 'spneumoniae', 'spseudintermedius', 'spyogenes', 'ssuis', 'sthermophilus', 'sthermophilus_2', 'streptomyces', 'suberis', 'szooepidemicus', 'taylorella', 'tenacibaculum', 'tvaginalis', 'vcholerae', 'vibrio', 'vparahaemolyticus', 'vtapetis', 'vvulnificus', 'wolbachia', 'xfastidiosa', 'yersinia', 'ypseudotuberculosis', 'yruckeri'])
    
    return final_params
}

