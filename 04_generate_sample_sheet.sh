#!/bin/bash

module load gcc/8.2.0
module load r/3.6.0

R --vanilla -f sample_sheet_creater.R --args FLOWCELL=$FLOWCELL OVERALL_FOLDER=$OVERALL_FOLDER

cd $OVERALL_DIR

chmod +rwx 05_mkfastq.sh
