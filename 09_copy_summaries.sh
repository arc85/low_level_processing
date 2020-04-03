cd /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_mat

declare -a FILES=($(ls | grep -v "CITE"))
ARRAYLENGTH=${#FILES[@]}

mkdir web_summaries

for (( i=0; i<${ARRAYLENGTH}; i++ ));
	do
		cd /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_mat/${FILES[i]}/outs
		mkdir ${FILES[i]}
		cp web_summary.html /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_mat/${FILES[i]}/outs/${FILES[i]}
		cp -r ${FILES[i]} /zfs1/tbruno/arc85/0_INBOX/novaseq_run4/novaseq4_mat/web_summaries
		echo "
		Copied ${FILES[i]}
		"
	done
