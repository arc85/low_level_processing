#!/bin/bash

source ./bin/07_define_align_array.sh
sbatch --array=$ARRAY ./bin/08_align.sbatch
