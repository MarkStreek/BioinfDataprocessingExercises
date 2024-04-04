In short, the SRRs Gene pipeline is (free) pipeline that can be used to download and process RNA-seq data. 
The RNA-seq is processed using the following steps:

1. Downloading the data from the SRA database
2. Quality report of the raw reads
3. Trimming the raw reads based on a given quality score
4. Trimming the adapter sequences given a reference file
5. Merging the paired-end reads into one file
6. Remvoving ribosomal RNA sequences with given databases
7. Unmerging the single reads into two files
8. Assembly of the reads into one fasta file
9. Create a reference genome with the assembly
10. Mapping the raw reads to the reference genome
11. Convert the alignment file to a (readable) sam file
12. Create a visualization of the alignment file (how many reads are mapped to the reference genome)

So, the pipeline is a very useful tool for processing RNA-seq data. Paired-end reads are the input of the pipeline and 
the output is a visualization of the alignment file.