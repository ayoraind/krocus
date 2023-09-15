#!/bin/bash

FILE=${1}

# extract species name from filename

species=$(echo ${FILE} | cut -f3 -d'_')


# process the file, shifting columns as needed. Only retain rows with third column containing values greater than 99

awk -v species="$species" 'BEGIN {OFS="\t"} $3 >= 99 { print $1, species, $2, $3, $4, $5, $6, $7, $8, $9, $10 }' $FILE  
