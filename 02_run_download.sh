#!/bin/bash

cd $OVERALL_DIR/ancillary_files
DOWNLINKS=($(ls | grep -Z "Download_Links"))

cut -d "," -f2 $DOWNLINKS > download_links.txt
dos2unix download_links.txt
mv download_links.txt $OVERALL_DIR

cd $OVERALL_DIR

FILE=($(while IFS= read -r line
  do
    echo "$line" | grep "http"
  done < download_links.txt
  ))

LENGTH=${#FILE[@]}

mkdir $RUN_FOLDER
cd $RUN_FOLDER

for (( i=0; i<${LENGTH}; i++ ));
  do
    echo "Downloading
    ${FILE[i]}
    "
    wget ${FILE[i]}
  done
