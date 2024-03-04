"""
This file...
"""

# rule fastqc:
#     input:
#         expand("/homes/mvandestreek/{sample}.fastq", sample=config['samples']),
#     output:
#         html="data/fastqc/qc/{sample}.html",
#         zip="data/fastqc/qc/{sample}_fastqc.zip"
#     params:
#         extra = "--quiet"
#     resources:
#         mem_mb = 1024
#     wrapper:
#         "v3.4.1/bio/fastqc"

# TODO: Change the below rule to a wrapper
# TODO: Use the directory from the config file config['samples_directory']

configfile: "config/config.yaml",
workdir: config['workdir'],

rule run_fastqc:
    input:
        #expand("/homes/mvandestreek/{sample}.fastq", sample=config['samples']),
        "/homes/mvandestreek/{sample}.fastq",
    output:
        html="results/{sample}_fastqc.html",
        zip="results/{sample}_fastqc.zip"
    resources:
        mem_mb = 1024
    wrapper:
        "v3.4.1/bio/fastqc"