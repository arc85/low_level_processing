##Transfer gene expression matrices to box
##TC Mar 31 2020

#Copy gene barcode matrices to new directory for transfer

cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat

declare -a FILES_GEX=($(ls | grep -v ".batch\|.out"))
ARRAYLENGTH=${#FILES_GEX[@]}

cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat/${FILES_GEX[0]}/outs
TOMOVE=($(ls | grep -v ".bam"))
cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat

mkdir mats_for_transfer

for (( i=0; i<${ARRAYLENGTH}; i++ ));
	do
		cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat/mats_for_transfer
		mkdir ${FILES_GEX[i]}
		cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat/${FILES_GEX[i]}/outs
    cp -r "${TOMOVE[@]}" /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat/mats_for_transfer/${FILES_GEX[i]}
		echo "
		Copied ${FILES_GEX[i]}
		"
	done


cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_citeseq

declare -a FILES_HASH=($(ls | grep -v ".batch\|.out\|.csv\|whitelists"))
ARRAYLENGTH2=${#FILES_HASH[@]}

mkdir mats_for_transfer

for (( i=0; i<${ARRAYLENGTH2}; i++ ));
	do
		cd /zfs1/tbruno/arc85/0_INBOX/novaseq3_citeseq/mats_for_transfer
		mkdir ${FILES_HASH[i]}
		cp -r /zfs1/tbruno/arc85/0_INBOX/novaseq3_citeseq/${FILES_HASH[i]} .
  	echo "
  		Copied ${FILES_HASH[i]}
  	"
	done


lftp -u "arc85@pitt.edu,pwd" ftps://ftp.box.com

mirror -c -R /zfs1/tbruno/arc85/0_INBOX/novaseq3_mat/mats_for_transfer \
	/scRNAseq_gene_cell_barcode_backup/scRNAseq_gene_cell_barcodes/human_data/temp_expression

mirror -c -R /zfs1/tbruno/arc85/0_INBOX/novaseq3_citeseq/mats_for_transfer \
	/scRNAseq_gene_cell_barcode_backup/scRNAseq_gene_cell_barcodes/human_data/temp_expression

exit
