#!/bin/bash

cd $OVERALL_DIR/input_files
DOWNLINKS=($(ls | grep -Z "Download_Links"))

cut -d "," -f3 $DOWNLINKS > expected_md5.txt

cut -d "," -f2 $DOWNLINKS > download_links.txt
dos2unix download_links.txt
mv download_links.txt $OVERALL_DIR
mv expected_md5.txt $OVERALL_DIR

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
    if [[$i == 0]]; then
      md5sum ${FILE[i]} | cut -d" " -f1 expected_md5_sum.tx > downloaded_md5.txt
    else
      md5sum ${FILE[i]} | cut -d" " -f1 expected_md5_sum.tx >> downloaded_md5.txt
    fi
  done

mv downloaded_md5.txt $OVERALL_DIR

cd $OVERALL_DIR

DIFF=$(diff downloaded_md5.txt expected_md5.txt)

if [ "$DIFF" != "" ]
  then
  exit 1
else
  exit 0
fi
