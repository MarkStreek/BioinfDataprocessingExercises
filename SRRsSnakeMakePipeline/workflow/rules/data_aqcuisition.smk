"""
This file contains a single rule to download the raw samples.
The fasterq-dump tool is used in a wrapper to download the samples.

AUTHOR: Mark van de Streek
DATE: 2024-04-05
"""


rule get_fastq_pe:
    """
    Rule to download samples from NCBI Archive. 
    The tool takes accession numbers as input and downloads the samples.
    Because this tool can't handle the '{sample}', everything is called '{accession}'
    ---------------------------------------------------------------------------------
    Output:
            - Left raw read in sample directory
            - Right raw read in sample directory 
    ---------------------------------------------------------------------------------
    """
    output:
        config["samples_directory"] + "{accession}_1.fastq",
        config["samples_directory"] + "{accession}_2.fastq",
    log:
        "logs/download/{accession}.log"
    message:
        "Downloading {accession} from the NCBI Archive"
    params:
        extra="--skip-technical --verbose"
    threads:
        config['threads']
    wrapper:
        "v3.5.3/bio/sra-tools/fasterq-dump"