rule mergeFastQ:
    input:
        r1="results/trimmomatic/{accession}_1_paired_trimmed.fastq",
        r2="results/trimmomatic/{accession}_2_paired_trimmed.fastq"
    output:
        "results/sortmerna/merged/{accession}_interleaved.fastq"
    conda:
        "../../envs/sortmerna.yaml"
    shell:
        "workflow/scripts/merge-paired-reads.sh {input.r1} {input.r2} {output}"

rule sortMeRNA:
    """
    SortMeRNA uses a Work directory with the default location $USER/sortmerna/run/. Sortmerna also checks kvdb directory. 
    This directory has to be Empty prior each new run. Therefore, we have to empty this before starting a new run.
    """
    input:
        ref1=config['rRNA_databases'] + "silva-bac-16s-id90.fasta",
        ref2=config['rRNA_databases'] + "silva-bac-23s-id98.fasta",
        ref3=config['rRNA_databases'] + "silva-arc-16s-id95.fasta", 
        ref4=config['rRNA_databases'] + "silva-arc-23s-id98.fasta",
        ref5=config['rRNA_databases'] + "silva-euk-18s-id95.fasta",
        ref6=config['rRNA_databases'] + "silva-euk-28s-id98.fasta",
        ref7=config['rRNA_databases'] + "rfam-5s-database-id98.fasta", 
        ref8=config['rRNA_databases'] + "rfam-5.8s-database-id98.fasta",
        accession="results/sortmerna/merged/{accession}_interleaved.fastq",
    output:
        nonRNA="results/sortmerna/{accession}_non_rRNA.fastq",
        alignedRNA="results/sortmerna/{accession}_rRNA.fastq",
    conda:
        "../../envs/sortmerna.yaml",
    threads: 
        threads=config['threads'],
    shell:
        """
        rm -rf ~/sortmerna/run/kvdb/*
        sortmerna --reads {input.accession} --ref {input.ref1} --ref {input.ref2} --ref {input.ref3} --num_alignments 1 --fastx --aligned {output.alignedRNA} --other {output.nonRNA} -a {threads} -m 64000 --paired_in -v
        mv {output.alignedRNA}.fq {output.alignedRNA} &&
        mv {output.nonRNA}.fq {output.nonRNA}
        """

rule unmergeFastQ:
    input:
        "results/sortmerna/{accession}_non_rRNA.fastq",
    output:
        r1="results/sortmerna/unmerged/{accession}_non_rRNA_1.fastq",
        r2="results/sortmerna/unmerged/{accession}_non_rRNA_2.fastq",
    shell:
        "workflow/scripts/unmerge-paired-reads.sh {input} {output.r1} {output.r2}"