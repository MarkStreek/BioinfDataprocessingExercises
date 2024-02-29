rule get_fasta:
    output:
        "results/test.fasta"
    log:
        "logs/get_fasta.log",
    params:
        id="KY785484.1",
        db="nuccore",
        format="fasta",
        # optional mode
        mode=None,
    wrapper:
        "v3.4.0/bio/entrez/efetch"

# snakemake -c 1 --use-conda --conda-frontend conda