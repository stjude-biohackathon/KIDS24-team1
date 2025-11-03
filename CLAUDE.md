# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CHROMIC (Comprehensive Omics Catalogue for Hartwell) data exploratory analysis tool for St. Jude Children's Research Hospital. This repository provides both command-line analysis scripts and a Shiny web application to visualize data availability across assays.

## Repository Structure

- `analyses/data-exploratory-analysis/` - R Markdown analysis pipeline
- `shiny/` - R Shiny web application for interactive data exploration
- `figures/` - Shared plotting themes and utilities

## Running Analyses

### Command-Line Analysis

From the analysis directory:
```bash
cd analyses/data-exploratory-analysis
bash run-data-exploratory-analysis.sh
```

The shell script loads required modules (designed for St Jude HPC):
- R/4.4.0
- pandoc/3.2
- texlive/20240326

To run individual analysis steps:
```bash
Rscript --vanilla run-data-exploratory-analysis.R
```

### Shiny Application

The Shiny app runs in `shiny/` directory with:
- `ui.R` - Interface definition with dark mode support
- `server.R` - Backend logic for report generation
- `www/` - Static assets, R Markdown templates, and utility scripts

Required R packages: shiny, shinyjs, knitr, shinythemes, httr, dplyr, tidyverse, shinyBS, rmarkdown, shinyWidgets, shinycustomloader, bslib

## Analysis Pipeline Architecture

The analysis follows a three-stage R Markdown workflow:

1. **01-create-cohort.Rmd** - Generate cohort with fake SJUIDs from demo data
2. **02-data-exploratory-analysis.Rmd** - Overall cohort analysis by assay type
3. **03-data-exploratory-analysis-longitudinal.Rmd** - Longitudinal patient-level analysis

### Key Parameters

Analysis scripts accept these configurable parameters:
- `input_file` - CSV input file path (in `./input/` directory)
- `cancer_type_order` - Factor levels for cancer types
- `assay_order` - Factor levels for assays
- `disease_stage_order` - Factor levels for disease stages (longitudinal only)
- `PROJECT_NAME`, `START_DATE`, `COMPLETION_DATE` - Report metadata

Edit parameters in `run-data-exploratory-analysis.R` before running.

### Output Structure

Outputs are saved to `analyses/data-exploratory-analysis/plots/`:
- HTML and PDF reports: `Report-[analysis-name]-[date].{html,pdf}`
- Figure directories: `figures/` and `figures-longitudinal/`
- Log files for each analysis step

## Shared Utilities

Located in both `analyses/data-exploratory-analysis/util/` and `shiny/www/scripts/`:
- `function-create-barplot.R` - Bar and stacked bar plot functions using custom theme
- `generate-fake-SJUID.R` - Generate fake patient identifiers for demo data
- `theme_plot.R` - Custom ggplot2 theme (`theme_Publication()`)

## Shiny Application Architecture

The Shiny app dynamically renders reports based on uploaded CSV files:
- Renders two types of HTML per analysis: fragment (embedded) and full (downloadable)
- Uses user-specific output directories: `www/[FragCohortOut|CohortOut|FragLongOut|LongOut]/[username]/`
- Integrates with St Jude API for user authentication (URL placeholder in server.R:44)
- Supports both cohort and longitudinal analyses

### Color Palettes

Custom color schemes in `shiny/www/palettes/`:
- `assay_color_palette.tsv`
- `tumor_color_palette.tsv`
- `longitudinal_color_palette.tsv`

## Input Data Format

CSV files should contain:
- Sample identifiers
- Cancer type information
- Assay type columns
- For longitudinal: patient IDs and disease stage

Templates available:
- `shiny/www/template.csv` - Empty template
- `shiny/www/dummy-data.csv` - Pre-filled demo data

## Development Notes

- HPC module loading is specific to St Jude infrastructure; adjust for local development
- The Shiny app disables SSL peer verification (line 10 of server.R) for internal API calls
- R Markdown files render to both HTML and PDF formats using `output_format = 'all'`
- Plotting functions expect specific column names and use position_stack for consistent ordering
