#!/bin/bash

source ./bin/07c_define_tcr_bcr_align_array.sh
sbatch --array $ARRAY_TCR_BCR ./bin/08b_align_tcr_bcr.sbatch
