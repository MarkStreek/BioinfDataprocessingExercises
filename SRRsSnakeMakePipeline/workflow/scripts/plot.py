#!/usr/bin/env python3
"""
This module...
"""

__author__ = "Mark van de Streek"
__version__ = "1.0.0"
__date__ = "18-04-2024"

import pysam
import matplotlib.pyplot as plt


def counted_mapped_reads(sam_file):
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
    mapped_reads, unmapped_reads = counted_mapped_reads(sam_file)
    labels = ['Mapped Reads', 'Unmapped Reads']
    sizes = [mapped_reads, unmapped_reads]
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140)
    plt.axis('equal')
    plt.title("Percentage of Mapped and Unmapped Reads")
    plt.savefig(output_file, format='jpg')
    plt.close()

sam_file = snakemake.input[0]
output_file = snakemake.output[0]
plot_mapped_reads(sam_file, output_file)
