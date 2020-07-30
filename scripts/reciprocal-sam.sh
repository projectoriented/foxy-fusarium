#!/bin/bash

fa=$1
sra=$2
n=${sra%%.*}

bwa index $fa

bwa mem -P $fa $sra > $n-aln.sam

samtools view -bS $n-aln.sam > $n-aln.bam
samtools sort $n-aln.bam -o $n-aln-sorted.bam
samtools index $n-aln-sorted.bam
samtools faidx $1
samtools bam2fq $n-aln-sorted.bam > $n-aln.fastq

spades.py -k 21,33,55 --careful -s $n-aln.fastq -o spades/
