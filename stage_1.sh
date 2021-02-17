#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_1
#SBATCH -t 1-0:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=40g
#SBATCH mail-user=arc85@pitt.edu
#SBATCH mail-type=ALL

mkdir $MAT_FOLDER

module load bcl2fastq2/2.20.0
BCL2FASTQ=/ihome/crc/install/cellranger/bcl2fastq2-v2.20.0/bin/bcl2fastq

source ./bin/01_setup.sh
source ./bin/02_run_download.sh
source ./bin/03_untar_downloaded_run.sh
source ./bin/04_generate_sample_sheet.sh

SAMPLESHEET=($(ls | grep "sample_sheet.csv"))

mkdir $FASTQ_FOLDER
cd $FASTQ_FOLDER

$BCL2FASTQ --use-bases-mask=Y28,I8,Y91 \
	--create-fastq-for-index-reads \
	--minimum-trimmed-read-length=8 \
	--mask-short-adapter-reads=8 \
	--ignore-missing-positions \
	--ignore-missing-controls \
	--ignore-missing-filter \
	--ignore-missing-bcls \
	--loading-threads 1 \
	--processing-threads 4 \
	--writing-threads 1 \
	--runfolder-dir $OVERALL_DIR/${RUN_FOLDER} \
	--output-dir $OVERALL_DIR/${FASTQ_FOLDER} \
	--interop-dir $OVERALL_DIR/${FASTQ_FOLDER} \
	--sample-sheet $OVERALL_DIR/${SAMPLESHEET} \
	--barcode-mismatches=0

source ./bin/06_folder_conversion.sh
