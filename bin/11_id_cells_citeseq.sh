#!/bin/bash

module load  gcc/8.2.0
module load r/3.6.0

R --vanilla -f id_cells_citeseq.R
