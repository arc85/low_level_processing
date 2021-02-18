#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_4
#SBATCH -t 2-00:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=60g
#SBATCH mail-user=$USER_FOR_EMAIL
#SBATCH mail-type=ALL

module load cellranger/3.1.0

cd ${OVERALL_DIR}/${TCR_BCR_FOLDER}

FILENAME=${TO_ALIGN_TCR_BCR[${SLURM_ARRAY_TASK_ID}]}

REFERENCE_PATH=$(sed 1d ./input_files/sample_info_sheet.csv |
  awk NR==${SLURM_ARRAY_TASK_ID}  |
  cut -d',' -f9)

echo ${SLURM_ARRAY_TASK_ID}
echo $FILENAME

cellranger vdj \
  --id=$FILENAME \
  --fastqs=$OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL} \
  --reference=$REFERENCE_PATH \
  --sample=$FILENAME \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=59
