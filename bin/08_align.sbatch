#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J count
#SBATCH -t 2-00:00:00

#SBATCH --cpus-per-task=8
#SBATCH --mem=120g
#SBATCH mail-user=arc85@pitt.edu
#SBATCH mail-type=ALL

module load cellranger/3.1.0

cd $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

TO_ALIGN=($(ls | grep -v "CITEseq\|Hash\|TCR\|BCR"))

cd $OVERALL_DIR/${MAT_FOLDER}

FILENAME=${TO_ALIGN[${SLURM_ARRAY_TASK_ID}]}

echo ${SLURM_ARRAY_TASK_ID}
echo $FILENAME

cellranger count \
  --id=$FILENAME \
  --fastqs=$OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL} \
  --transcriptome=/bgfs/genomics/refs/CellRanger/refdata-cellranger-GRCh38-3.0.0 \
  --sample=$FILENAME \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=119
