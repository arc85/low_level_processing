#!/bin/bash

module load gcc/8.2.0
module load r/3.6.0

R --vanilla -f ./lib/R/define_gex_samples.R

mkdir $MAT_FOLDER
source ./bin/05_define_align_array.sh

sbatch --array=$ARRAY --mail-user=$USER_FOR_EMAIL ./bin/06_align.sbatch
