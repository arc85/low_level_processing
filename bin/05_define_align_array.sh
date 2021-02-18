#!/bin/bash

module load  gcc/8.2.0
module load r/3.6.0

R --vanilla -f ./lib/R/define_gex_samples.R

TO_ALIGN=$(cat ./input_files/gex_samples_for_array.csv)
ALIGN_LENGTH=${#TO_ALIGN[@]}
ALIGN_LENGTH=$(expr $ALIGN_LENGTH - 1)
ARRAY="0-$ALIGN_LENGTH"

export TO_ALIGN
export ARRAY

mkdir $MAT_FOLDER
