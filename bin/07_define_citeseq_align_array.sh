#!/bin/bash

TO_ALIGN_CITESEQ=($(cat ./input_files/citeseq_samples_for_array.csv))
ALIGN_LENGTH_CITESEQ=${#TO_ALIGN_CITESEQ[@]}
ALIGN_LENGTH_CITESEQ=$(expr $ALIGN_LENGTH_CITESEQ - 1)
ARRAY_CITESEQ="0-$ALIGN_LENGTH_CITESEQ"
