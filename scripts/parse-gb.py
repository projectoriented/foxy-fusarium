#!/usr/bin/ python3.6

from Bio import SeqIO

count = SeqIO.convert("complete-cdna.gb", "genbank", "complete-cdna.fa", "fasta")

print("Converted %i records" % count)
