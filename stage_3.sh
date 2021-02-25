#!/bin/bash

source ./bin/01_setup.sh

module load gcc/8.2.0
module load r/3.6.0

R --vanilla -f ./lib/R/define_citeseq_samples.R

mkdir $CITESEQ_FOLDER
source ./bin/07_define_citeseq_align_array.sh

R --vanilla -f ./lib/R/id_cells_citeseq.R --args OVERALL_DIR=$OVERALL_DIR FASTQ_FOLDER=$FASTQ_FOLDER FLOWCELL=$FLOWCELL MAT_FOLDER=$MAT_FOLDER CITESEQ_FOLDER=$CITESEQ_FOLDER

sbatch --array $ARRAY_CITESEQ --mail-user=$USER_FOR_EMAIL ./bin/08_citeseq_count.sbatch
