# Pipeline for Data exploratory analysis

## Usage

To run the script in this module from the command line sequentially, use:

```
bash run-data-exploratory-analysis.sh
```

`run-data-exploratory-analysis.sh` is designed to be run as if it was called from this module directory even when called from outside of this directory.

Parameters according to the project and analysis strategy will need to be specified in the following scripts:
- `run-data-exploratory-analysis.R`: define `root_dir` and `params`, if necessary. User should add their data in the `./input` as csv file and define the file in the `params`.
- `run-data-exploratory-analysis-step1-2-3.R.R`: Same as the first one. This one is for generating cohort with demo data and run the `02-data-exploratory-analysis.Rmd` and `03-data-exploratory-analysis-longitudinal.Rmd`. If the user needs to perform something similar, they should edit the `run-data-exploratory-analysis.sh` file as well with the correct R script to run.


The module runs for the following tools: `R`, `pandoc` and `texlive`. Versions are defined in the `run-data-exploratory-analysis.sh`, and relative modules exist and run automatically from St Jude HPC. In addition, the `tidyverse` R package are required to run the `02-data-exploratory-analysis.Rmd` and `03-data-exploratory-analysis-longitudinal.Rmd`.


## Folder content

This folder contains a script tasked to analyze the distribution of samples across the project.


### Methods

This is an exploratory analysis of the data availability in terms of assays in the Comprehensive Omics Catalogue for Hartwell. 

For demo purposes, we provide an example for the `./input/demo-data.csv`. We subset this data by human brain tumor samples to use as an example cohort. In addition, we generate random fake SJUID per brain cancer type as this information is not contained in the demo cohort.


## Folder structure 

The structure of this folder is as follows:

```
├── 01-create-cohort.Rmd
├── 02-data-exploratory-analysis.Rmd
├── 03-data-exploratory-analysis-longitudinal.Rmd
├── gitignore.txt
├── input
|   ├── cohort-longitudinal.csv
|   ├── cohort.csv
|   └── demo-data.csv
├── plots
|   ├── figures
|   |   ├── cancer-type-brain-assay-overall.pdf
|   |   ├── cancer-type-brain-per-assay.pdf
|   |   └── samples-per-assay.pdf
|   ├── figures-longitudinal
|   |   ├── cancer-type-brain-assay-overall-longitudinal.pdf
|   |   ├── cancer-type-brain-patient-longitudinal.pdf
|   |   ├── cancer-type-brain-per-assay-patient.pdf
|   |   └── samples-per-assay.pdf
|   ├── Report-create-cohort-<Sys.Date()>.html
|   ├── Report-create-cohort-<Sys.Date()>.pdf
|   ├── Report-data-exploratory-analysis-<Sys.Date()>.html
|   ├── Report-data-exploratory-analysis-<Sys.Date()>.pdf
|   ├── Report-data-exploratory-analysis-longitudinal-<Sys.Date()>.html
|   └── Report-data-exploratory-analysis-longitudinal-<Sys.Date()>.pdf
├── README.md
├── Report-create-cohort-<Sys.Date()>.log
├── Report-data-exploratory-analysis-<Sys.Date()>.log
├── Report-data-exploratory-analysis-longitudinal-<Sys.Date()>.log
├── run-data-exploratory-analysis-step1-2-3.R
├── run-data-exploratory-analysis.R
├── run-data-exploratory-analysis.sh
└── util
|   ├── function-create-barplot.R
|___└── generate-fake-SJUID.R
```