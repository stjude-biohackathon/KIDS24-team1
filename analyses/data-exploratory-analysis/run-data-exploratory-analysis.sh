#!/bin/bash

set -e
set -o pipefail

# Set up modules
module load R/4.4.0
module load pandoc/3.2
module load texlive/20240326 #to load LaTeX on a compute node

# set up running directory
cd "$(dirname "${BASH_SOURCE[0]}")" 

################################################################################################################
# Run all scripts of the module
Rscript --vanilla run-data-exploratory-analysis.R
################################################################################################################
