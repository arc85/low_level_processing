#!/bin/bash

source ./bin/07b_define_citeseq_align_array.sh
R --vanilla -f ./lib/R/id_cells_citeseq.R

sbatch --array $ARRAY_CITESEQ ./bin/12_citeseq_count.sbatch
