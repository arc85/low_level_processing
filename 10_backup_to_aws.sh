##Backup Files to AWS
##TC Mar 30 2020

HOME_DIR=/zfs1/tbruno/arc85/0_INBOX/novaseq_run4/200323_A00364_0096_AHNVFCDMXX
RUN=200323_A00364_0096_AHNVFCDMXX
FASTQ_DIR=/zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_fastq/
CHIP=HNVFCDMXX

##On HTC
module load python/3.7.0

##Activate AWS on HTC
AWS=/ihome/tbruno/arc85/.local/bin/aws


##Save metrics from Illumina run
##Upload metadata

$AWS s3 cp $OVERALL_DIR/${RUN_FOLDER} s3://vignali-lab-backup/single_cell_rnaseq_human/FASTQ_files/5prime_data/gene_expression/$RUN_FOLDER/metadata --recursive --exclude "*" --include "*.txt" --include "*.xml" --include "*.csv"


##Upload FASTQ.gz

$AWS s3 cp --recursive $OVERALL_DIR/${FASTQ_FOLDER}/${FLOWCELL} s3://vignali-lab-backup/single_cell_rnaseq_human/FASTQ_files/5prime_data/gene_expression/$RUN_FOLDER/deplex_fastq/${FLOWCELL}/


##Upload demultiplex stats folders

$AWS s3 cp --recursive $OVERALL_DIR/${FASTQ_FOLDER}/Stats s3://vignali-lab-backup/single_cell_rnaseq_human/FASTQ_files/5prime_data/gene_expression/$RUN_FOLDER/deplex_fastq/Stats

$AWS s3 cp --recursive $OVERALL_DIR/${FASTQ_FOLDER}/Reports s3://vignali-lab-backup/single_cell_rnaseq_human/FASTQ_files/5prime_data/gene_expression/$RUN_FOLDER/deplex_fastq/Reports
