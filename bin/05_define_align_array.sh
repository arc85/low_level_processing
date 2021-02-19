#!/bin/bash

TO_ALIGN=($(cat ./input_files/gex_samples_for_array.csv))
ALIGN_LENGTH=${#TO_ALIGN[@]}
ALIGN_LENGTH=$(expr $ALIGN_LENGTH - 1)
ARRAY="0-$ALIGN_LENGTH"
