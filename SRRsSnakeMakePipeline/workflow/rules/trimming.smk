rule fastx_toolkit:
    """
    This tool has verbose specified, but runs first all operations, 
    and then prints the output.
    """
    input:
        s1=config["samples_directory"] + "{accession}_1.fastq",
        s2=config["samples_directory"] + "{accession}_2.fastq"
    output:
        s1="results/fastx/filtered_{accession}_1.fastq",
        s2="results/fastx/filtered_{accession}_2.fastq"
    message:
        "Running fastx_toolkit on {input}"
    conda:
        "../../envs/FASTX_TOOLKIT.yaml"
    shell:
        """
        fastq_quality_filter -v -q 20 -p 75 -i {input.s1} -o {output.s1}
        fastq_quality_filter -v -q 20 -p 75 -i {input.s2} -o {output.s2}
        """

rule trimmomatic_pe:
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
    params:
        trimmer=[
            "ILLUMINACLIP:../adapters/TruSeq3-PE.fa:2:30:10",
            "SLIDINGWINDOW:5:20",
            "LEADING:5",
            "TRAILING:5",
            "MINLEN:50"],
        compression_level="-9"
    threads:
        config['threads']
    resources:
        mem_mb=config['memory_mb']
    wrapper:
        "v3.5.2/bio/trimmomatic/pe"