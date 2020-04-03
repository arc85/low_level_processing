#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J citeseq
#SBATCH -t 12:00:00
#SBATCH --array=0-4

#SBATCH --cpus-per-task=4
#SBATCH --mem=32g

#This script creates a SLURM batch file to run citseqcount on numerous files

module load cite-seq-count/1.4.3

cd /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/ancillary_files

cut -d "," -f2 novaseq4_simple_sample.csv > sample_names.txt

NAMES=($(while IFS= read -r line
  do
    echo "$line" | grep -v "Sample" | grep "Hash" 
  done < sample_names.txt
  ))

cd /zfs1/tbruno/arc85/0_INBOX/miseq_run.20.02.20/miseq_run3_unhashing/
WHITELIST=${FILES[${SLURM_ARRAY_TASK_ID}]}.csv
LENGTH=$(cat $WHITELIST | wc -l)

cd /zfs1/tbruno/arc85/0_INBOX/miseq_run.20.02.20/miseq_run3_fastq/outs/fastq_path/CR4BK/${FILES[${SLURM_ARRAY_TASK_ID}]}

READ1=($(ls | grep -Z "_R1_"))
READ2=($(ls | grep -Z "_R2_"))

CITE-seq-Count -R1 $READ1 -R2 $READ2 \
	-t /zfs1/tbruno/arc85/0_INBOX/miseq_run.20.02.20/miseq_run3_unhashing/citeseq_tags.csv \
	-cbf 1 -cbl 16 -umif 17 -umil 28 \
	-cells $LENGTH \
	-wl /zfs1/tbruno/arc85/0_INBOX/miseq_run.20.02.20/miseq_run3_unhashing/$WHITELIST \
	-o /zfs1/tbruno/arc85/0_INBOX/miseq_run.20.02.20/miseq_run3_unhashing/${FILES[${SLURM_ARRAY_TASK_ID}]} \
	-T 4