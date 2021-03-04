#!/bin/bash
#SBATCH -p htc
#SBATCH -N 1
#SBATCH -J stage_3
#SBATCH -t 12:00:00

#SBATCH --cpus-per-task=4
#SBATCH --mem=40g
#SBATCH --mail-type=ALL

module load cite-seq-count/1.4.3

source ./bin/01_setup.sh
source ./bin/07_define_citeseq_align_array.sh

FILENAME=${TO_ALIGN_CITESEQ[${SLURM_ARRAY_TASK_ID}]}
REFERENCE_PATH=$(sed 1d ./input_files/sample_info_sheet.csv |
  grep "CITEseq" |
  awk NR==$(expr ${SLURM_ARRAY_TASK_ID} + 1) |
  cut -d',' -f8)

echo ""
echo ${SLURM_ARRAY_TASK_ID}
echo $FILENAME
echo ""

WHITELIST=${OVERALL_DIR}/${CITESEQ_FOLDER}/whitelists/${TO_ALIGN_CITESEQ[${SLURM_ARRAY_TASK_ID}]}.csv
LENGTH=$(cat $WHITELIST | wc -l)

cd ${OVERALL_DIR}/${FASTQ_FOLDER}/${FLOWCELL}/${TO_ALIGN_CITESEQ[${SLURM_ARRAY_TASK_ID}]}

cat $(ls | grep -Z "_R1_") > r1_merged_fastq.gz
cat $(ls | grep -Z "_R2_") > r2_merged_fastq.gz

cd ${OVERALL_DIR}

READ1=${OVERALL_DIR}/${FASTQ_FOLDER}/${FLOWCELL}/${TO_ALIGN_CITESEQ[${SLURM_ARRAY_TASK_ID}]}/r1_merged_fastq.gz
READ2=${OVERALL_DIR}/${FASTQ_FOLDER}/${FLOWCELL}/${TO_ALIGN_CITESEQ[${SLURM_ARRAY_TASK_ID}]}/r2_merged_fastq.gz

CITE-seq-Count -R1 $READ1 -R2 $READ2 \
	-t ${REFERENCE_PATH} \
  -cbf 1 -cbl 16 -umif 17 -umil 26 \
	-trim 10 \
	-cells $LENGTH \
	-wl ${WHITELIST} \
	-o ${OVERALL_DIR}/${CITESEQ_FOLDER}/${TO_ALIGN_CITESEQ[${SLURM_ARRAY_TASK_ID}]} \
	-T 4
