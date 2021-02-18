#!/bin/bash

source ./bin/09_define_tcr_bcr_align_array.sh
sbatch --array $ARRAY_TCR_BCR ./bin/10_align_tcr_bcr.sbatch
