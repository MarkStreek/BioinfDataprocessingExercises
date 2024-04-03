"""
Trimming rules for the snakemake workflow.
Fastx toolkit trims the raw reads based on quality scores.
Trimmomatic trims the adapters using the reference file.

AUTHOR: Mark van de Streek
DATE: 2024-04-05
"""

rule fastx_toolkit:
    """
    Fastx toolkit is a collection of command line tools.
    For this operation, we are using fastq_quality_filter.
    -q 20: minimum quality score of 20
    -p 75: 75% of the bases must have a quality score of 20 or higher
    -----------------------------------------------------------------
    Input:
        r1: left raw read
        r2: right raw read
    Output:
        r1: left filtered read
        r2: right filtered read
    -----------------------------------------------------------------
    """
    input:
        r1=config["samples_directory"] + "{accession}_1.fastq",
        r2=config["samples_directory"] + "{accession}_2.fastq"
    output:
        r1="results/fastx/filtered_{accession}_1.fastq",
        r2="results/fastx/filtered_{accession}_2.fastq"
    log:
        "logs/fastx/{accession}.log"
    message:
        "Running fastx_toolkit on {input}"
    conda:
        "../../envs/FASTX_TOOLKIT.yaml"
    shell:
        """
        fastq_quality_filter -v -q 20 -p 75 -i {input.r1} -o {output.r1} 2> {log}
        fastq_quality_filter -v -q 20 -p 75 -i {input.r2} -o {output.r2} 2> {log}
        """

rule trimmomatic_pe:
    """
    Running trimmomatic on the filtered reads.
    Removes the adapters from the reads.
    Options:
        SLIDINGWINDOW: 5:20 : Remove bases with quality lower than 20 in a window of 5 bases
        LEADING: 5 : Remove bases with quality lower than 5 at the beginning
        TRAILING: 5 : Remove bases with quality lower than 5 at the end
        MINLEN: 50 : Remove reads with length lower than 50
    ----------------------------------------------------------------------------------------
    Input:
            - r1: left filtered read
            - r2: right filtered read
    Output:
            - r1: left trimmed read
            - r2: right trimmed read
            - r1_unpaired: left unpaired read
            - r2_unpaired: right unpaired read
    ----------------------------------------------------------------------------------------
    """
    input:
        r1="results/fastx/filtered_{accession}_1.fastq",
        r2="results/fastx/filtered_{accession}_2.fastq"
    output:
        r1="results/trimmomatic/{accession}_1_paired_trimmed.fastq",
        r2="results/trimmomatic/{accession}_2_paired_trimmed.fastq",
        r1_unpaired="results/trimmomatic/{accession}_1_unpaired_trimmed.fastq",
        r2_unpaired="results/trimmomatic/{accession}_2_unpaired_trimmed.fastq"
    log:
        "logs/trimmomatic/{accession}.log"
    message:
        "Running trimmomatic on {input}"
    params:
        trimmer=[
            "ILLUMINACLIP:" + config['workdir'] + "/adapters/TruSeq3-PE.fa:2:30:10",
            "SLIDINGWINDOW:5:20",
            "LEADING:5",
            "TRAILING:5",
            "MINLEN:50"],
        compression_level="-9",
        extra="",
    threads:
        config['threads']
    resources:
        mem_mb=config['memory_gb'] * 1000
    wrapper:
        "v3.5.2/bio/trimmomatic/pe"