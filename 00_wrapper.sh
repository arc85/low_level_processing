#!/bin/bash

source 01_setup.sh
source 02_run_download.sh
source 03_untar_downloaded_run.sh
source 04_generate_sample_sheet.sh
sbatch 05_mkfastq.sbatch
wait
source 06_folder_conversion.sh
source 07_define_align_array.sh
sbatch 08_align.sbatch --array=$ARRAY
wait
source 09_copy_summaries.sh
