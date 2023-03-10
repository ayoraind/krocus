#!/bin/bash

FILE=${1}
#LIST=$2

#STAT=$(basename $(basename ${LIST}) .txt)
#echo "Filename"$'\t'"Total"$'\t'"mapped_reads"$'\t'"unmapped_reads"$'\t'"proportion_mapped"$'\t'"proportion_unmapped" > ${FILE}.mappedstats.txt

#printf "%s\t%s\t%s\t%s\t%s\t%s\n" $FILE $total $mapped_reads $unmapped_reads $proportion_mapped $proportion_unmapped >> ${FILE}.mappedstats.txt

cat $FILE | sed '$!N; /^\(.*\)\n\1$/!P; D' | column -t -s $'\t' | sort -k 2 -n -r | uniq -f 2 | awk '!seen[$1]++'
