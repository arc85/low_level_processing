#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J count
#SBATCH -t 2-00:00:00
#SBATCH --array=0-6

#SBATCH --cpus-per-task=8
#SBATCH --mem=120g

module load cellranger/3.1.0

cd /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/ancillary_files

cut -d "," -f2 novaseq4_simple_sample.csv > sample_names.txt

NAMES=($(while IFS= read -r line
  do
    echo "$line" | grep -v "Sample\|Hash"
  done < sample_names.txt
  ))

cd /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_mat

FILENAME=${NAMES[${SLURM_ARRAY_TASK_ID}]}

echo $FILENAME

cellranger count \
  --id=$FILENAME \
  --fastqs=/zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_fastq/HNVFCDMXX \
  --transcriptome=/bgfs/genomics/refs/CellRanger/refdata-cellranger-GRCh38-3.0.0 \
  --sample=$FILENAME \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=119
