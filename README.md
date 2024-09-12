# KIDS24-team1

* THIS BRANCH CONTAINS `./services/` from the first version of [CHROMIC](https://chromic.stjude.org). This now has removed in private repo. 


The `KIDS24-team1` repository contains:
(1) Django API and webclient framework [CHROMIC](https://chromic.stjude.org) (Comprehensive Omics Catalogue for Hartwell), and
(2) code and results with a demo example to perform an exploratory analysis of the data availability in terms of assays in the CHROMIC. 

This repository and efforts aim to facilitate collaboration across departments at St Jude, expedite discoveries, and find cures for children with cancer and other catastrophic diseases.


## To reproduce the code in this repository:
This repository contains the code used to conduct analyses for the repository noted above.

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
|  └── data-exploratory-analysis
├── gitignore.txt
├── img
|  └── chromic-logo.png
├── LICENSE
└── README.md
├── services
|  └── api
|      └── hackathon24Team1
|          ├── hackathon24Team1
|          ├── manage.py
|          ├── omicsbackend
|          ├── README.md
|          └── requirements.txt
|  └── webclient
|      └── chromic_frontend
|          ├── index.html
|          ├── jsconfig.json
|          ├── package-lock.json
|          ├── package.json
|          ├── README.md
|          ├── src
|_________ └── vite.config.mjs
```

## Contact

Contributions, issues, and feature requests are welcome! Please feel free to check [issues](https://github.com/stjude-biohackathon/KIDS24-team1/issues).
For more support email us at [chromic@stjude.org](chromic@stjude.org).

