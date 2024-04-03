"""
This file contains the assembly rule of the pipeline.
A Trinity wrapper is used for the assembly. 
The used memory and threads are defined in the config file.

AUTHOR: Mark van de Streek
DATE: 2024-04-05
"""


rule trinity_assembly:
    """
    Trinity wrapper for the assembly of the non-rRNA reads.
    The reads are assembled into contigs. The reads are free of rRNA, 
    these were removed already in earlier rules.
    -----------------------------------------------------------------
    Input:
            - left: left reads
            - right: right reads
    Output:
            - tempory directory
            - fasta file (the assembled contigs)
            - gene trans map
    -----------------------------------------------------------------
    """
    input:
        left=["results/sortmerna/unmerged/{accession}_non_rRNA_1.fastq"],
        right=["results/sortmerna/unmerged/{accession}_non_rRNA_2.fastq"],
    output:
        dir=temp(directory("results/trinity/trinity_{accession}/")),
        fas="results/trinity/trinity_{accession}.Trinity.fasta",
        map="results/trinity/trinity_{accession}.Trinity.fasta.gene_trans_map",
    log:
        "logs/trinity/trinity_{accession}.log"
    message:
        "Running Trinity for the assembly of the non-rRNA reads."
    params:
        extra="",
    threads:
        config['threads']
    resources:
        mem_gb=config['memory_gb']
    wrapper:
        "v3.5.3/bio/trinity"