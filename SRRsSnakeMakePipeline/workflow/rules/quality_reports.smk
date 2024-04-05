"""
This file contains the rules to create quality reports.
FastQC creates a zip/html that contains quality information about the raw reads.
plot_reads creates a plot that shows the number of mapped reads on the reference genome.

AUTHOR: Mark van de Streek
DATE: 2024-04-05
"""

rule fastQC:
    """
    Run the FastQC tool on the raw reads. 
    The FastQC tools creates a zip folder and a html file,
    that contains quality information about the raw reads.
    ------------------------------------------------------
    Input:
            - Raw reads
    Output:
            - Zip folder with quality information
            - HTML file with quality information
    ------------------------------------------------------
    """
    input:
        config["samples_directory"] + "{accession}_1.fastq",
        config["samples_directory"] + "{accession}_2.fastq"
    output:
        "results/fastqc/{accession}_1_fastqc.html",
        "results/fastqc/{accession}_1_fastqc.zip",
        "results/fastqc/{accession}_2_fastqc.html",
        "results/fastqc/{accession}_2_fastqc.zip",
    log:
        "logs/fastqc/{accession}.log"
    message:
        "Running FastQC on {input}"
    conda:
        "../../envs/FASTQC.yaml"
    params:
        threads=config['threads']
    shell:
        "fastqc -t {params.threads} {input} -o results/fastqc/ 2> {log}"

rule plot_reads:
    """
    Rule that creates a (pie) chart that shows the percentage of mapped reads on the reference genome.
    The rule is using a python3 script to create the plot. See the python file for more information.
    --------------------------------------------------------------------------------------------------
    Input:
            - SAM file with mapped reads
    Output:
            - JPG file with the plot (final file of the pipeline)
    --------------------------------------------------------------------------------------------------
    """
    input:
        "results/mapped/{accession}.sam"
    output:
        report("results/plots/{accession}_reads.jpg", caption="../../report/visualization.rst", category="final_visualization")
    log:
        "logs/plots/{accession}.log"
    message:
        "Creating plot for {input}"
    script:
        "../scripts/plot.py"
