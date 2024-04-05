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
.
├── SRRsSnakeMakePipeline
│   ├── adapters
│   ├── benchmarks
│   ├── config
│   ├── envs
│   ├── images
│   ├── logs
│   │   ├── *
│   ├── report
│   ├── results
│   │   ├── *
│   ├── slurm
│   ├── sortme_references
│   └── workflow
│       ├── rules
|       ├── Snakefile
│       └── scripts
├── tutorial_01
│   ├── config
│   ├── images
│   ├── resources
│   │   └── *
│   ├── results
│   └── workflow
│       ├── rules
|       ├── Snakefile
│       └── scripts
└── tutorial_02
    ├── config
    ├── images
    ├── resources
    │   └── *
    ├── results
    └── workflow
        ├── rules
        ├── Snakefile
        └── scripts
```

## The Transcriptomic to SRRs Gene pipeline

In short, the SRRs Gene pipeline is (free) pipeline that can be used to download and process RNA-seq data. The RNA-seq is processed using the following steps:

1. Downloading the data from the SRA database
2. Quality report of the raw reads
3. Trimming the raw reads based on a given quality score
4. Trimming the adapter sequences given a reference file
5. Merging the paired-end reads into one file
6. Remvoving ribosomal RNA sequences with given databases
7. Unmerging the single reads into two files
8. Assembly of the reads into one fasta file
9. Create a reference genome with the assembly
10. Mapping the raw reads to the reference genome
11. Convert the alignment file to a (readable) sam file
12. Create a visualisation of the alignment file (how many reads are mapped to the reference genome)

## Go to [SRRs Gene Pipeline](SRRsSnakeMakePipeline/README.md)
