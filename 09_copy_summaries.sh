#!/bin/bash

cd $MAT_FOLDER

declare -a FILES=($(ls))
ARRAYLENGTH=${#FILES[@]}

mkdir web_summaries

for (( i=0; i<${ARRAYLENGTH}; i++ ));
	do
		cd $OVERALL_DIR/${MAT_FOLDER}/${FILES[i]}/outs
		mkdir ${FILES[i]}
		cp web_summary.html ${FILES[i]}
		cp -r ${FILES[i]} $OVERALL_DIR/${MAT_FOLDER}/web_summaries/
		rm -r ${FILES[i]}
		echo "
		Copied ${FILES[i]}
		"
	done

cd $OVERALL_DIR
