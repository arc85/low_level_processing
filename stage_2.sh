#!/bin/bash

source ./bin/05_define_align_array.sh
sbatch --array=$ARRAY ./bin/06_align.sbatch
