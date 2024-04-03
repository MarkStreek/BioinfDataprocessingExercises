"""
This file contains three rules for the SortMeRNA workflow. 
The first rule merges the paired-end reads into a single interleaved file. 
The second rule runs SortMeRNA on the interleaved file and separates the rRNA and non-rRNA reads. 
The third rule unmerges the paired-end reads from the non-rRNA reads.

AUTHOR: Mark van de Streek
DATE: 2024-04-05
"""

rule mergeFastQ:
    """
    Merge the paired-end reads into a single interleaved file.
    The SortMeRNA tool requires the reads to be interleaved.
    The bash script merge-paired-reads.sh is used to merge the paired-end reads.
    ----------------------------------------------------------------------------
    Input:
            - r1: left paired-end read file after quality trimming
            - r2: right paired-end read file after quality trimming
    Output:
            - interleaved: merged paired-end reads
    ----------------------------------------------------------------------------
    """
    input:
        r1="results/trimmomatic/{accession}_1_paired_trimmed.fastq",
        r2="results/trimmomatic/{accession}_2_paired_trimmed.fastq"
    output:
        "results/sortmerna/merged/{accession}_interleaved.fastq"
    log:
        "logs/sortmerna/mergeFastQ/{accession}.log"
    message:
        "Merging paired-end reads into a single interleaved file"
    conda:
        "../../envs/sortmerna.yaml"
    shell:
        "workflow/scripts/merge-paired-reads.sh {input.r1} {input.r2} {output} 2> {log}"

rule sortMeRNA:
    """
    SortMeRNA removes rRNA reads from the interleaved file. This is done using the reference databases provided by SortMeRNA.
    The reference databases are strored in the sortmerna_references folders.
    SortMeRNA uses a Work directory with the default location $USER/sortmerna/run/. Sortmerna also checks kvdb directory. 
    This directory has to be Empty prior each new run. Therefore, we have to empty this before starting a new run.
    Default extension is .fq, but we change it to .fastq to be consistent with the rest of the workflow.
    -------------------------------------------------------------------------------------------------------------------------
    Input:
            - ref1: 16S rRNA reference database
            - ref2: 23S rRNA reference database
            - ref3: 16S rRNA reference database
            - ref4: 23S rRNA reference database
            - ref5: 18S rRNA reference database
            - ref6: 28S rRNA reference database
            - ref7: 5S rRNA reference database
            - ref8: 5.8S rRNA reference database
            - accession: interleaved file with merged paired-end reads
    Output:
            - nonRNA: non-rRNA reads
            - alignedRNA: rRNA reads
    -------------------------------------------------------------------------------------------------------------------------
    """
    input:
        ref1=config['workdir'] + config['rRNA_databases'] + "silva-bac-16s-id90.fasta",
        ref2=config['workdir'] + config['rRNA_databases'] + "silva-bac-23s-id98.fasta",
        ref3=config['workdir'] + config['rRNA_databases'] + "silva-arc-16s-id95.fasta", 
        ref4=config['workdir'] + config['rRNA_databases'] + "silva-arc-23s-id98.fasta",
        ref5=config['workdir'] + config['rRNA_databases'] + "silva-euk-18s-id95.fasta",
        ref6=config['workdir'] + config['rRNA_databases'] + "silva-euk-28s-id98.fasta",
        ref7=config['workdir'] + config['rRNA_databases'] + "rfam-5s-database-id98.fasta", 
        ref8=config['workdir'] + config['rRNA_databases'] + "rfam-5.8s-database-id98.fasta",
        accession="results/sortmerna/merged/{accession}_interleaved.fastq",
    output:
        nonRNA="results/sortmerna/{accession}_non_rRNA.fastq",
        alignedRNA="results/sortmerna/{accession}_rRNA.fastq"
    log:
        "logs/sortmerna/sortMeRNA/{accession}.log"
    message:
        "Running SortMeRNA on {input.accession} to remove rRNA reads"
    conda:
        "../../envs/sortmerna.yaml",
    threads: 
        threads=config['threads'],
    shell:
        """
        rm -rf ~/sortmerna/run/kvdb/*
        sortmerna --reads {input.accession} --ref {input.ref1} --ref {input.ref2} --ref {input.ref3} --num_alignments 1 --fastx --aligned {output.alignedRNA} --other {output.nonRNA} -a {threads} -m 64000 --paired_in -v 2> {log}
        mv {output.alignedRNA}.fq {output.alignedRNA} &&
        mv {output.nonRNA}.fq {output.nonRNA}
        """

rule unmergeFastQ:
    """
    Unmerge the paired-end reads from the non-rRNA reads. 
    After removing the rRNA reads, the paired-end reads can be unmerged again.
    --------------------------------------------------------------------------
    Input:
            - accession: non-rRNA reads
    Output:
            - r1: left paired-end read file after removing rRNA reads
            - r2: right paired-end read file after removing rRNA reads
    --------------------------------------------------------------------------
    """
    input:
        "results/sortmerna/{accession}_non_rRNA.fastq",
    output:
        r1="results/sortmerna/unmerged/{accession}_non_rRNA_1.fastq",
        r2="results/sortmerna/unmerged/{accession}_non_rRNA_2.fastq"
    log:
        "logs/sortmerna/unmergeFastQ/{accession}.log"
    message:
        "Unmerging paired-end reads from non-rRNA reads"
    shell:
        "workflow/scripts/unmerge-paired-reads.sh {input} {output.r1} {output.r2} 2> {log}"