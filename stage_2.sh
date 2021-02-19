#!/bin/bash

source ./bin/01_setup.sh
source ./bin/05_define_align_array.sh
sbatch --array=$ARRAY --mail-user=$USER_FOR_EMAIL ./bin/06_align.sbatch
