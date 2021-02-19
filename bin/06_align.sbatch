#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_2
#SBATCH -t 2-00:00:00

#SBATCH --cpus-per-task=8
#SBATCH --mem=120g
#SBATCH mail-type=ALL

module load cellranger/3.1.0

cd $OVERALL_DIR/${MAT_FOLDER}

FILENAME=${TO_ALIGN[${SLURM_ARRAY_TASK_ID}]}
REFERENCE_PATH=$(sed 1d ./input_files/sample_info_sheet.csv |
  awk NR==${SLURM_ARRAY_TASK_ID}  |
  cut -d',' -f7)

echo ""
echo ${SLURM_ARRAY_TASK_ID}
echo $FILENAME
echo ""

cellranger count \
  --id=$FILENAME \
  --fastqs=$OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL} \
  --transcriptome=$REFERENCE_PATH \
  --sample=$FILENAME \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=119
