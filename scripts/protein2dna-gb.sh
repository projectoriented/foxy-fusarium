#!/bin/bash

# This script retrieves the cDNA genbank file from protein genbank records.

# genbank file as argument
file=$1

# take all unique locus tags
locus_tags=$(cat $1 | grep 'locus_tag' | grep -o '".*"' | sed 's/"//g' | uniq)

for i in $locus_tags
do
	# capture the annotation line from Entrez output and get the start, stop, and accession number from it
    anno=$(esearch -db gene -query "$i" < /dev/null | efetch | grep 'Annotation')

    start=$(echo $anno | cut -f2 -d'(' | sed 's/\..*//')
    stop=$(echo $anno | cut -f2 -d'(' | sed 's/.*\.//; s/[,a-z)]//g')
    accn=$(echo $anno | cut -f4 -d' ')

    # get the genbank file with the captured accn, start, and start. 
    efetch -db nuccore -format gb -id "$accn" -seq_start $start -seq_stop $stop  

done
