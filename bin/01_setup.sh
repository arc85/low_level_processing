#!/bin/bash

while IFS= read -r line
  do
    declare $(echo "$line" | cut -d, -f1)=$(echo "$line" | cut -d, -f2)
  done < ./input_files/variable_names.csv
