#!/bin/bash

source 01_setup.sh
source 02_run_download.sh
source 03_untar_downloaded_run.sh
source 04_generate_sample_sheet.sh
srun -n1 -t04:00:00 --cpus-per-task=4 --mem=40g 05_mkfastq.sh
exit
source 06_folder_conversion.sh
source 07_define_align_array.sh
sbatch --array=$ARRAY 08_align.sbatch
#build 09_xxx.sh into sbatch to run when the array completes
