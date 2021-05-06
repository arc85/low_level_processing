#!/bin/bash

cd $OVERALL_DIR/input_files
DOWNLINKS=($(ls | grep -Z "Download_Links"))

cut -d "," -f3 $DOWNLINKS | sed 1d > expected_md5.txt

cut -d "," -f2 $DOWNLINKS | sed 1d > download_links.txt

mv expected_md5.txt $OVERALL_DIR

cut -d "," -f1 $DOWNLINKS | sed 1d > file_names.txt

FILE_NAME=($(while IFS= read -r line
  do
    echo "$line"
  done < file_names.txt
  ))

FILE=($(while IFS= read -r line
  do
    echo "$line"
  done < download_links.txt
  ))

rm file_names.txt download_links.txt

cd $OVERALL_DIR

LENGTH=${#FILE[@]}

mkdir $RUN_FOLDER
cd $RUN_FOLDER

for (( i=0; i<${LENGTH}; i++ ));
  do
    echo "Downloading
    ${FILE[i]}
    "
    wget ${FILE[i]}
    if [ $i == 0 ]
      then
        md5sum ${FILE_NAME[i]} | cut -d" " -f1 > downloaded_md5.txt
      else
        md5sum ${FILE_NAME[i]} | cut -d" " -f1 >> downloaded_md5.txt
    fi
  done

mv downloaded_md5.txt $OVERALL_DIR
