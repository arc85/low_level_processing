#!/bin/bash

# Ensure input file formats are correct
sed -i 's/\r//' ./input_files/variable_names.csv
sed -i 's/\r//' ./input_files/Download_Links.csv
sed -i 's/\r//' ./input_files/sample_info_sheet.csv

while IFS= read -r line
  do
    declare $(echo "$line" | cut -d, -f1)=$(echo "$line" | cut -d, -f2)
  done < ./input_files/variable_names.csv
