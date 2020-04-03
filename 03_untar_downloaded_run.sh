#!/bin/bash

cd $OVERALL_DIR/${RUN_FOLDER}

for FILES in *.tar.gz;
  do
    tar xzvf "${FILES}" && rm "${FILES}";
  done
