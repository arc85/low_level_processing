#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J vdj
#SBATCH -t 2-00:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=60g

module load cellranger/3.1.0

cd $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL}

TO_ALIGN_TCR_BCR=($(ls | grep "TCR\|BCR"))

cd $OVERALL_DIR/${MAT_FOLDER}

FILENAME=${TO_ALIGN_TCR_BCR[${SLURM_ARRAY_TASK_ID}]}

echo ${SLURM_ARRAY_TASK_ID}
echo $FILENAME

cellranger vdj \
  --id=$FILENAME \
  --fastqs=$OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL} \
  --reference=/bgfs/genomics/refs/CellRanger/refdata-cellranger-vdj-GRCh38-alts-ensembl-3.1.0 \
  --sample=$FILENAME \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=59
