#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_1
#SBATCH -t 1-0:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=40g
#SBATCH --mail-type=ALL

module load bcl2fastq2/2.20.0
BCL2FASTQ=/ihome/crc/install/cellranger/bcl2fastq2-v2.20.0/bin/bcl2fastq

module load gcc/8.2.0
module load r/3.6.0

source ./bin/01_setup.sh
source ./bin/02_run_download.sh

DIFF=$(diff downloaded_md5.txt expected_md5.txt)

if [ "$DIFF" != "" ]
  then
    echo ""
    echo "MD5sum doesn't match expected"
    echo ""
    exit 1
  else
    echo ""
    echo "MD5sum matches, proceeding"
    echo ""
  fi

source ./bin/03_untar_downloaded_run.sh

INDEX_CHECK=($(cut -d',' -f3 ./input_files/sample_info_sheet.csv | sed 1d | grep "\\-GA\\-\|\\-NA\\-"))
INDEX_CHOICE=${#INDEX_CHECK[@]}

if [ $INDEX_CHOICE  != 0 ]

 	then

		R --vanilla -f ./lib/R/sample_sheet_creator.R --args FLOWCELL=$FLOWCELL OVERALL_FOLDER=$OVERALL_FOLDER

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
			--sample-sheet $OVERALL_DIR/${SAMPLESHEET}

		cd ..

	else

		R --vanilla -f ./lib/R/sample_sheet_creator.R --args FLOWCELL=$FLOWCELL OVERALL_FOLDER=$OVERALL_FOLDER

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
			--sample-sheet $OVERALL_DIR/${SAMPLESHEET}

		cd ..

	fi

source ./bin/04_folder_conversion.sh
