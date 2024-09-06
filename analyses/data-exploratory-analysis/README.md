# Pipeline for Data exploratory analysis

## Usage

To run the script in this module from the command line sequentially, use:

```
bash run-data-exploratory-analysis.sh
```

`run-data-exploratory-analysis.sh` is designed to be run as if it was called from this module directory even when called from outside of this directory.

Parameters according to the project and analysis strategy will need to be specified in the following scripts:
- `run-data-exploratory-analysis.R`: define `root_dir` and `params`, if necessary

The module runs for the following tools: `R`, `pandoc` and `texlive`. Versions are defined in the `run-data-exploratory-analysis.sh`, and relative modules exist and run automatically from St Jude HPC. In addition, the `tidyverse` and `flextable` R packages are required to run the `01-data-exploratory-analysis.Rmd` script.


## Folder content

This folder contains a script tasked to analyze the distribution of samples across the project.


### Methods

This is an exploratory analysis of the data availability in terms of assays in the Comprehensive Omics Catalogue for Hartwell. 

For demo purposes, we provide an example for the `./input/demo-data.csv`. We subset this data by human brain tumor samples to use as an example cohort. 


## Folder structure 

The structure of this folder is as follows:

```
├── 01-data-exploratory-analysis.Rmd
├── input
|   └── demo-data.csv
├── plots
|   ├── Report-data-exploratory-analysis-<Sys.Date()>.html
|   └── Report-data-exploratory-analysis-<Sys.Date()>.pdf
├── README.md
├── results
|   └── cohort.tsv
├── run-data-exploratory-analysis.R
└── run-data-exploratory-analysis.sh
```