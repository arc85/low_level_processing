#!/bin/bash

source ./bin/01_setup.sh

module load gcc/8.2.0
module load r/3.6.0

R --vanilla -f ./lib/R/define_tcr_bcr_samples.R

mkdir $TCR_BCR_FOLDER
source ./bin/09_define_tcr_bcr_align_array.sh

sbatch --array $ARRAY_TCR_BCR --mail-user=$USER_FOR_EMAIL ./bin/10_align_tcr_bcr.sbatch
