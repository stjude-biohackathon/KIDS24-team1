# KIDS24-team1

The `KIDS24-team1` contains code and results with a demo example to perform an exploratory analysis of the data availability in terms of assays in the Comprehensive Omics Catalogue for Hartwell. This is critical for mitigating duplicate sequencing requests and efforts through Hartwell. This repo aims to showcase:
(1) what data have already been sequenced by Hartwell and 
(2) what omics data are available per sample.

The current exploratory data analysis can be expanded by investigating samples with paired assays.
Moreover, if other metadata are available, e.g., disease_stage, treatment, this will lead to build large, longitudinal cohorts with multi-omic sequencing data. Such an analysis permits to consider samples according to the condition(s) of the experiment and research aims, accordingly. In addition, it can be used to refine research questions and/or generate new ones.

This will facilitate collaboration across departments at St Jude, expedite discoveries, and find cures for children with cancer and other catastrophic diseases.


## To reproduce the code in this repository:
This repository contains the code used to conduct analyses for the manuscript noted above.

1. Clone the repository
```
git clone https://github.com/stjude-biohackathon/KIDS24-team1.git
```

2. Navigate to an analysis module and run the shell script:
```
cd $(dirname "${BASH_SOURCE[0]}")/KIDS24-team1/analyses/module_of_interest
```

### Below is the main directory structure listing the analyses and data files used in this repository

```
├── analyses
|  └── sample-distribution-analysis
├── img
|  └── chromic-logo.png
├── gitignore.txt
├── LICENSE
└── README.md
```

## Contact

For questions, please submit an issue.
