#!/bin/bash

export OVERALL_DIR='/Overall_run_directory/'
export OVERALL_FOLDER='Run_folder'
export RUN_FOLDER='Run_name'
export FLOWCELL='Flowcell'
export FASTQ_FOLDER='Fastq_folder'
export MAT_FOLDER='matrix_folder'
chmod +rws 05_mkfastq.sh

mkdir $MAT_FOLDER
