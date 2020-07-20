#!/bin/bash

cd $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

TO_ALIGN=($(ls | grep -v "hash\|TCR\|BCR"))
ALIGN_LENGTH=${#TO_ALIGN[@]}
ALIGN_LENGTH=$(expr $ALIGN_LENGTH - 1)
ARRAY="0-$ALIGN_LENGTH"

export TO_ALIGN
export ARRAY

TO_ALIGN_TCR_BCR=($(ls | grep "TCR\|BCR"))
ALIGN_LENGTH_TCR_BCR=${#TO_ALIGN_TCR_BCR[@]}
ALIGN_LENGTH_TCR_BCR=$(expr $ALIGN_LENGTH_TCR_BCR - 1)
ARRAY_TCR_BCR="0-$ALIGN_LENGTH_TCR_BCR"

export TO_ALIGN_TCR_BCR
export ARRAY_TCR_BCR

cd $OVERALL_DIR

mkdir "$MAT_FOLDER"_tcr_bcr_mat
