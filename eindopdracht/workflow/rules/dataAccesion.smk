# Data file where the samples are downloaded

rule download_samples:
    output:
        "data/{sample}.fastq"
    shell:
        "prefetch {sample} -O ./data"