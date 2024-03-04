"""
This files contains the rule for running the FASTQC Tool.
The rule uses a FASTQC wrapper to run the process. 
The results are saved in the results directory.

Author: Mark van de Streek
Date: 2021-07-01
-------------------------------------------------------------------------------------
input:
    {sample}.fastq: The input fastq file sample (declared in config file)
output:
    {sample}_fastqc.html: The html file containing the results of the FASTQC analysis
    {sample}_fastqc.zip: The zip file containing the results of the FASTQC analysis
-------------------------------------------------------------------------------------
"""

configfile: "config/config.yaml",
workdir: config['workdir'],

rule run_fastqc:
    input:
        "/homes/mvandestreek/{sample}.fastq",
        # TODO: config["samples_directory"] + "{sample}.fastq",
    output:
        html="results/{sample}_fastqc.html",
        zip="results/{sample}_fastqc.zip"
    resources:
        mem_mb = 1024
    wrapper:
        "v3.4.1/bio/fastqc"