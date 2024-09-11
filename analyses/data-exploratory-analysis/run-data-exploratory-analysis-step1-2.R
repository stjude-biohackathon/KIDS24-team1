#################################################################################
# This will run all scripts in the `sample-distribution-analysis`
#################################################################################
# Set up directories and paths to root_dir and analysis_dir
root_dir <- file.path("/research/dept/dnb/core_operations/Bioinformatics/achroni/GitHub/KIDS24-team1")
analysis_dir <- file.path(root_dir, "analyses", "data-exploratory-analysis")
report_dir <- file.path(analysis_dir, "plots") 

################################################################################################################
# Run Rmd script
################################################################################################################
rmarkdown::render('01-create-cohort.Rmd', clean = TRUE,
                                          output_dir = file.path(report_dir),
                                          output_file = c(paste('Report-', 'create-cohort', '-', Sys.Date(), sep = '')),
                                          output_format = 'all',
                                          params = list(input_file = "demo-data.csv",

                                                        # the following parameters should be similar across the module
                                                        PROJECT_NAME = "Comprehensive Omics Catalogue for Hartwell",
                                                        START_DATE = "09/04/2024",
                                                        COMPLETION_DATE = "9/06/2024"))
################################################################################################################
rmarkdown::render('02-data-exploratory-analysis.Rmd', clean = TRUE,
                                                      output_dir = file.path(report_dir),
                                                      output_file = c(paste('Report-', 'data-exploratory-analysis', '-', Sys.Date(), sep = '')),
                                                      output_format = 'all',
                                                      params = list(input_file = "cohort.csv", # as generated from the first step or user's cohort
                                                                    cancer_type_order = c("Ependymoma", "HGG", "LGG", "Medulloblastoma"), # Level df by cancer type
                                                                    assay_order = c("WES", "WGBS", "WGS", "RNAseq", "ATACseq", "ChIPseq", "Methylation"), # Level df by assay
                                                         
                                                                    # the following parameters should be similar across the module
                                                                    PROJECT_NAME = "Comprehensive Omics Catalogue for Hartwell",
                                                                    START_DATE = "09/04/2024",
                                                                    COMPLETION_DATE = "9/06/2024"))
################################################################################################################