#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_4
#SBATCH -t 1-00:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=60g
#SBATCH --mail-type=ALL

module load cellranger/3.1.0

source ./bin/01_setup.sh
source ./bin/09_define_tcr_bcr_align_array.sh

FILENAME=${TO_ALIGN_TCR_BCR[${SLURM_ARRAY_TASK_ID}]}
REFERENCE_PATH=$(sed 1d ./input_files/sample_info_sheet.csv |
  grep "TCR\|BCR" |
  awk NR==$(expr ${SLURM_ARRAY_TASK_ID} + 1) |
  cut -d',' -f9 |
  tr -d '\r')

echo ""
echo ${SLURM_ARRAY_TASK_ID}
echo $FILENAME
echo $REFERENCE_PATH
echo ""

cd $OVERALL_DIR/${TCR_BCR_FOLDER}

cellranger vdj \
  --id=$FILENAME \
  --fastqs=${OVERALL_DIR}/${FASTQ_FOLDER}/${FLOWCELL} \
  --reference=${REFERENCE_PATH} \
  --sample=$FILENAME \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=59
