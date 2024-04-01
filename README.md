# BioinfDataprocessingExercises

This repository contains the exercises for the course dataprocessing. 
Bioinformatics, Hanze University of Applied Sciences.

[![Snakemake](https://img.shields.io/badge/snakemake-≥5.6.0-brightgreen.svg?style=flat)](https://snakemake.readthedocs.io)
[![Bioconda](https://img.shields.io/conda/dn/bioconda/snakemake.svg?label=Bioconda)](https://bioconda.github.io/recipes/snakemake/README.html)
[![Pypi](https://img.shields.io/pypi/pyversions/snakemake.svg)](https://pypi.org/project/snakemake)

## Structure of the project

The directories *tutorial_01* and *tutorial_02* are tutorials for the course. In these basic directories, there are some exercises to get familiar with the basics of Snakemake.

The [SRRsSnakeMakePipeline](SRRsSnakeMakePipeline/README.md) folder contains the main pipeline for the course. Some more information about the pipeline is provided below.

```bash
|-- SRRsSnakeMakePipeline
|   |-- adapters
|   |-- benchmarks
|   |-- config
|   |-- envs
|   |-- images
|   |-- logs
|   |-- results
|   |-- slurm
|   |-- sortme_references
|   `-- workflow
        |-- rules
        |   |-- download2.smk
        |-- scripts
        |   `-- script1.py
        `-- Snakefile
```

## The Transcriptomic to SRRs Gene pipeline

In short, the SRRs Gene pipeline is (free) pipeline that can be used to download and process RNA-seq data. The RNA-seq is processed using the following steps:

1. Downloading the RNA-seq data using accession numbers (SRRs)
2. Quality reports of the RNA-seq data
3. Trimming the RNA-seq data below a certain quality threshold
4. Trimming the RNA-seq data for adapters
5. Remove ribosomal RNA from the RNA-seq data
6. Assemble the RNA-seq data

## Go to [SRRs Gene Pipeline](SRRsSnakeMakePipeline/README.md)
