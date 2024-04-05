#!/usr/bin/env python3
"""
This module creates a pie chart vizualisation for the pipeline.
It counts the number of mapped and unmapped reads in a SAM file 
and plots the percentage of mapped and unmapped reads.
"""

__author__ = "Mark van de Streek"
__version__ = "1.0.0"
__date__ = "2024-04-05"

import pysam
import matplotlib.pyplot as plt
import sys


def counted_mapped_reads(sam_file):
    """
    Function that counts the number of mapped and unmapped reads in a SAM file.
    The pysam module is used to read the SAM file and count the reads.
    ---------------------------------------------------------------------------
    Parameters:
            - sam_file: str
    Returns:
            - mapped_reads: int
            - unmapped_reads: int
    ---------------------------------------------------------------------------
    """
    mapped_reads = 0
    unmapped_reads = 0
    with pysam.AlignmentFile(sam_file, "r") as samfile:
        for read in samfile:
            if not read.is_unmapped:
                mapped_reads += 1
            else:
                unmapped_reads += 1
        
    return mapped_reads, unmapped_reads


def plot_mapped_reads(sam_file, output_file):
    """
    Function that creates the pie chart vizualisation for the pipeline.
    It calls the counted_mapped_reads function to count the number of mapped and unmapped reads.
    The matplotlib module is used to plot the pie chart.
    --------------------------------------------------------------------------------------------
    Parameters:
            - sam_file: str
            - output_file: str
    --------------------------------------------------------------------------------------------
    """
    # Call the function to count the number of mapped and unmapped reads
    mapped_reads, unmapped_reads = counted_mapped_reads(sam_file)
    labels = ['Mapped Reads', 'Unmapped Reads']
    sizes = [mapped_reads, unmapped_reads]
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140)
    plt.axis('equal')
    plt.title("Percentage of Mapped and Unmapped Reads")
    # Save the plot as a jpg file
    plt.savefig(output_file, format='jpg')
    plt.close()

with open(snakemake.log[0], "w") as f:
    # Redirecting stdout and stderr to the log file
    sys.stderr = sys.stdout = f
    # Define the input and output files
    sam_file = snakemake.input[0]
    output_file = snakemake.output[0]
    # Call the function
    plot_mapped_reads(sam_file, output_file)
