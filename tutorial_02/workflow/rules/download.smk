"""
Snake file that downloads the files from:
https://bioinf.nl/~ronald/snakemake/test.txt file via a Snakefile
"""



rule download:
    output:
        "{sample}.txt"
    shell:
        "wget {url}{output}"
