#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_3
#SBATCH -t 12:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=40g
#SBATCH mail-user=arc85@pitt.edu
#SBATCH mail-type=ALL

#This script creates a SLURM batch file to run citseqcount on numerous files

module load cite-seq-count/1.4.3

cd ${OVERALL_DIR}/${CITESEQ_FOLDER}/whitelists
WHITELIST=${TO_ALIGN_CITESEQ}[${SLURM_ARRAY_TASK_ID}]}.csv
LENGTH=$(cat $WHITELIST | wc -l)

cd ${OVERALL_DIR}/${FASTQ_FOLDER}/${FLOWCELL}/${TO_ALIGN_CITESEQ}[${SLURM_ARRAY_TASK_ID}]}

cat $(ls | grep -Z "_R1_") > r1_merged_fastq.gz
cat $(ls | grep -Z "_R2_") > r2_merged_fastq.gz

READ1=r1_merged_fastq.gz
READ2=r2_merged_fastq.gz

CITE-seq-Count -R1 $READ1 -R2 $READ2 \
	-t ${OVERALL_DIR}/ancillary_files/citeseq_large_panel_tags.csv \
  -cbf 1 -cbl 16 -umif 17 -umil 26 \
	-trim 10 \
	-cells $LENGTH \
	-wl ${OVERALL_DIR}/${CITESEQ_FOLDER}/whitelists/$WHITELIST \
	-o ${OVERALL_DIR}/${CITESEQ_FOLDER}/${TO_ALIGN_CITESEQ}[${SLURM_ARRAY_TASK_ID}]} \
	-T 4
