rule bowtie2_build:
    input:
        ref="results/trinity/trinity_{accession}.Trinity.fasta",
    output:
        multiext(
            "results/bowtie2_build/{accession}_genome",
            ".1.bt2",
            ".2.bt2",
            ".3.bt2",
            ".4.bt2",
            ".rev.1.bt2",
            ".rev.2.bt2",
        ),
    log:
        "logs/bowtie2/{accession}.log",
    params:
        extra="",
    threads:
        config['threads']
    wrapper:
        "v3.7.0/bio/bowtie2/build"

rule bowtie2:
    input:
        sample=[config["samples_directory"] + "{accession}_1.fastq", config["samples_directory"] + "{accession}_2.fastq" ],
        idx=multiext(
            "results/bowtie2_build/{accession}_genome",
            ".1.bt2",
            ".2.bt2",
            ".3.bt2",
            ".4.bt2",
            ".rev.1.bt2",
            ".rev.2.bt2",
        ),
    output:
        "results/mapped/{accession}.bam",
    log:
        "logs/bowtie2/{accession}.log",
    params:
        extra="",
    threads:
        config['threads']
    wrapper:
        "v3.7.0/bio/bowtie2/align"

rule bam_to_sam:
    input:
        "results/mapped/{accession}.bam"
    output:
        "results/mapped/{accession}.sam"
    log:
        "logs/samtools/{accession}.log"
    conda:
        "../../envs/ConvertBAM_SAM.yaml"
    threads:
        config['threads']
    shell:
        "samtools view -h {input} > {output} 2> {log} --threads {threads}"