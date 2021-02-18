#!/bin/bash

SAMPLESHEET=($(ls | grep "sample_sheet.csv"))

cut -d "," -f3,2 $SAMPLESHEET | grep -v "Index\|Sample" | grep -Z "SI" > reorder.txt

Rscript -e '
  to.edit <- read.csv("reorder.txt",header=F)
  to.edit <- unique(to.edit)
  write.table(to.edit,"reorder.txt",row.names=FALSE,quote=FALSE,sep=",",col.names=F)
'
mv reorder.txt $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

cd $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

while IFS=, read orig target; do
    mv "$orig" "$target"
done < reorder.txt

rm reorder.txt

cd $OVERALL_DIR
