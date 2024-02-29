rule download_samples_cofig:
    output:
        "{sample}.bam"
    shell:
        "wget {url}{output}"