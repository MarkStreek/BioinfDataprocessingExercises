# SRRsSnakeMakePipeline

[![Snakemake](https://img.shields.io/badge/snakemake-≥5.6.0-brightgreen.svg?style=flat)](https://snakemake.readthedocs.io)

This directory contains the main pipeline for the course. The pipeline is (partly) reproduced from the [Scientific report - Raw transcriptomics data to gene specific SSRs: a validated free bioinformatics workflow for biologists](https://www.nature.com/articles/s41598-020-75270-8). The pipeline is a free pipeline that can be used to download and process RNA-seq data.

------

<details>
<summary>Show table of contents</summary>

- [SRRsSnakeMakePipeline](#srrssnakemakepipeline)
  - [Quick start](#quick-start)
  - [Short description of the pipeline](#short-description-of-the-pipeline)
    - [Snakemake](#snakemake)
    - [Conda](#conda)
  - [Important steps before running the pipeline](#important-steps-before-running-the-pipeline)

</details>

------

## Quick start

The pipeline can be used by running the following command:

```bash
snakemake -c all --use-conda --conda-frontend conda
```

> ATTENTION: There are several steps that are needed to be done before running the pipeline. These steps are mentioned below. [Go to steps](#important-steps-before-running-the-pipeline)

## Short description of the pipeline

As mentioned above, the pipeline is a free pipeline that processes RNA-seq data. Nowadays, NGS data can be sequenced at a fairly low cost. However, many tools to proces this data are commercial and very expensive. Therefore, it's still a challenge to process the data in a cost-effective way. Most bioinformatics tools are fairly standalone. In this project, a de novo transcription pipeline is highlighted.

The pipeline contains the following steps/tools:

1.

### Snakemake

This pipeline is created using [Snakemake](https://snakemake.readthedocs.io/en/stable/index.html). Snakemake is a workflow management system that is used to create reproducible and scalable data analyses. The pipeline is created using a Snakefile. The Snakefile contains the rules that are used to process the data.

### Conda

Conda is the environment manager that is used to create the environments for the pipeline. The tools needed for this project are not manually installed, but are installed using conda. This way, the pipeline is more reproducible and scalable. And easier to install on different systems.

The tools are stored inside channels. The channels are defined in a .yaml file. Snakemake uses this file to create the environments. It looks inside the files for which channels are needed and installs the tools from the channels.

## Important steps before running the pipeline
