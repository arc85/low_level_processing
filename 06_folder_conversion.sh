#!/bin/bash

cd $OVERALL_DIR
SAMPLESHEET=($(ls | grep "sample_sheet.csv"))

cut -d "," -f3,2 $SAMPLESHEET | grep -v "Index\|Sample" > reorder.txt

mv reorder.txt $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

cd $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

while IFS=, read orig target; do
    mv "$target" "$orig"
done < reorder.txt

rm -r reorder.txt
