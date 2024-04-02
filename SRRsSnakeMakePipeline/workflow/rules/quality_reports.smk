rule fastQC:
    input:
        config["samples_directory"] + "{accession}_1.fastq",
        config["samples_directory"] + "{accession}_2.fastq"
    output:
        "results/fastqc/{accession}_1_fastqc.html",
        "results/fastqc/{accession}_1_fastqc.zip",
        "results/fastqc/{accession}_2_fastqc.html",
        "results/fastqc/{accession}_2_fastqc.zip",
    message:
        "Running FastQC on {input}"
    conda:
        "../../envs/FASTQC.yaml"
    params:
        threads=config['threads']
    shell:
        "fastqc -t {params.threads} {input} -o results/fastqc/"

rule plot_reads:
    input:
        "results/mapped/{accession}.sam"
    output:
        "results/plots/{accession}_reads.jpg"
    script:
        "../scripts/plot.py"