#!/bin/bash

module load  gcc/8.2.0
module load r/3.6.0

R --vanilla -f ./lib/R/define_citeseq_samples.R

TO_ALIGN_CITESEQ=$(cat ./input_files/citeseq_samples_for_array.csv)
ALIGN_LENGTH_CITESEQ=${#TO_ALIGN_CITESEQ[@]}
ALIGN_LENGTH_CITESEQ=$(expr $ALIGN_LENGTH_CITESEQ - 1)
ARRAY_CITESEQ="0-$ALIGN_LENGTH_CITESEQ"

export TO_ALIGN_CITESEQ
export ARRAY_CITESEQ

mkdir $CITESEQ_FOLDER
