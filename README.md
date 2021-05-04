# Processing of scRNAseq data from 10X and Illumina
## Updated February 25, 2021

This goal of this pipeline is to facilitate reproducible processing of 10X Genomics data through a standardized workflow.

## Distinct stages of processing

1. Download raw sequencing data, check MD5sums, untar, run bcl2fastq
2. SLURM array for GEX alignment
3. SLURM array for CITEseqCount (dependent on completion of stage 2)
4. SLURM array for TCR/BCR alignment

## May 4, 2021 changes

1. Refactoring of lib/R/sample_info_sheet.R to accomodate new indices from 10X
2. Add meaningful errors to check formatting of initial input files 

## Future features to create

1. Automate backup to Pitt Box and/or AWS
2. Aggregate web summaries from GEX and TCR/BCR alignment and run_info from CITEseqCount
