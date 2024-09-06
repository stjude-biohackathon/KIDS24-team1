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
rmarkdown::render('01-data-exploratory-analysis.Rmd', clean = TRUE,
                              output_dir = file.path(report_dir),
                              output_file = c(paste('Report-', 'data-exploratory-analysis', '-', Sys.Date(), sep = '')),
                              output_format = 'all',
                              params = list(
                                # the following parameters are defined in the `yaml` file
                                 PROJECT_NAME = "Comprehensive Omics Catalogue for Hartwell",
                                 START_DATE = "09/04/2024",
                                 COMPLETION_DATE = "9/06/2024",
                                 input_file = "demo-data.csv"))
################################################################################################################
