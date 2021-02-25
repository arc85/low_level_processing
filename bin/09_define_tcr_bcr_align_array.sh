#!/bin/bash

TO_ALIGN_TCR_BCR=($(cat ./input_files/tcr_bcr_samples_for_array.csv))
ALIGN_LENGTH_TCR_BCR=${#TO_ALIGN_TCR_BCR[@]}
ALIGN_LENGTH_TCR_BCR=$(expr $ALIGN_LENGTH_TCR_BCR - 1)
ARRAY_TCR_BCR="0-$ALIGN_LENGTH_TCR_BCR"
