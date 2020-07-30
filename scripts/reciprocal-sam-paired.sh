#!/bin/bash

fa=$1
sra1=$2
sra2=$3
n=${sra1%_*}

bwa index $fa

bwa mem -t 12 $fa $sra1 $sra2 > $n-aln.sam
rm $sra1 $sra2

samtools view -bS $n-aln.sam > $n-aln.bam
samtools sort $n-aln.bam -o $n-aln-sorted.bam
samtools index $n-aln-sorted.bam
samtools faidx $fa
samtools bam2fq $n-aln-sorted.bam > $n-aln.fastq

#spades.py -k 21,33,55 --careful -s $n-aln.fastq -o .
