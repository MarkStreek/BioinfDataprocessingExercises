# Data file where the samples are downloaded

rule download_samples:
    output:
        "results/{sample}.fastq"
    shell:
        "fasterq-dump {wildcards.sample} -O ./data"