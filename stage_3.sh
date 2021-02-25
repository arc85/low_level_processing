#!/bin/bash

source ./bin/07_define_citeseq_align_array.sh
R --vanilla -f ./lib/R/id_cells_citeseq.R --args OVERALL_DIR=$OVERALL_DIR FASTQ_FOLDER=$FASTQ_FOLDER FLOWCELL=$FLOWCELL MAT_FOLDER=$MAT_FOLDER CITESEQ_FOLDER=$CITESEQ_FOLDER

sbatch --array $ARRAY_CITESEQ ./bin/08_citeseq_count.sbatch
