#!/bin/bash

file=$1 # summary sra file

cat $file | while read line
do
	paired=$(sed '1d' | grep -w 'PAIRED' | cut -f1 -d',')
	single=$(sed '1d' | grep -w 'SINGLE' | cut -f1 -d',')
	echo "$line $single"

done


