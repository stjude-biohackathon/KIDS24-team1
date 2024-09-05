# Pipeline for Sample distribution analysis

## Usage

To run the script in this module from the command line sequentially, use:

```
bash run-sample-distribution-analysis.sh
```

`run-sample-distribution-analysis.sh` is designed to be run as if it was called from this module directory even when called from outside of this directory.

Parameters according to the project and analysis strategy will need to be specified in the following scripts:
- `run-sample-distribution-analysis.R`: define `root_dir` and `params`, if necessary


## Folder content

This folder contains a script tasked to analyze the distribution of samples across the project.


### Methods

This is an exploratory analysis of the data availability in terms of assays in the Comprehensive Omics Catalogue for Hartwell. 

For demo purposes, we provide an example for the `./input/demo-data.csv`. We subset this data by human brain tumor samples to use as an example cohort. 


## Folder structure 

The structure of this folder is as follows:

```
├── 01-sample-distribution-analysis.Rmd
├── input
|   └── demo-data.csv
├── plots
|   ├── Report-sample-distribution-analysis-<Sys.Date()>.html
|   └── Report-sample-distribution-analysis-<Sys.Date()>.pdf
├── README.md
├── results
|   └── cohort.tsv
├── run-sample-distribution-analysis.R
└── run-sample-distribution-analysis.sh
```