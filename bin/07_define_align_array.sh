#!/bin/bash

cd $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

TO_ALIGN=($(ls | grep -v "Hash\|hash\|CITEseq\|TCR\|BCR"))
ALIGN_LENGTH=${#TO_ALIGN[@]}
ALIGN_LENGTH=$(expr $ALIGN_LENGTH - 1)
ARRAY="0-$ALIGN_LENGTH"

export TO_ALIGN
export ARRAY
