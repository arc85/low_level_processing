#!/bin/bash

module load  gcc/8.2.0
module load r/3.6.0

R --vanilla -f ./lib/R/define_tcr_bcr_samples.R

TO_ALIGN_TCR_BCR=$(cat ./input_files/tcr_bcr_samples_for_array.csv)
ALIGN_LENGTH_TCR_BCR=${#TO_ALIGN_TCR_BCR[@]}
ALIGN_LENGTH_TCR_BCR=$(expr $ALIGN_LENGTH_TCR_BCR - 1)
ARRAY_TCR_BCR="0-$ALIGN_LENGTH_TCR_BCR"

export TO_ALIGN_TCR_BCR
export ARRAY_TCR_BCR

mkdir $TCR_BCR_FOLDER
