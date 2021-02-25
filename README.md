# Processing of scRNAseq data from 10X and Illumina
## Updated February 25, 2021

This goal of this pipeline is to facilitate reproducible processing of 10X Genomics data through a standardized workflow.

## Distinct stages of processing

1. Download raw sequencing data, check MD5sums, untar, run bcl2fastq
2. SLURM array for GEX alignment
3. SLURM array for CITEseqCount (dependent on completion of stage 2)
4. SLURM array for TCR/BCR alignment

## February 25, 2021 changes

1. Refactoring of the code into distinct stages, separating binaries into bin and R scripts into lib/R
2. Creating the following input files:
    1. variable_names.csv - create environment variables from specified names
    2. sample_info_sheet.csv - specify the types of libraries (i.e. GEX, CITEseq, TCR/BCR) and the references that should be used for each
    3. Update citeseq tags - 10 human and 10 murine in one list, separate list of a large CITEseq panel of surface antibodies
3. Setting up SLURM to send emails upon completion of stages

## Future features to create

1. Automate backup to Pitt Box and/or AWS
2. Aggregrate web summaries from GEX and TCR/BCR alignment and run_info from CITEseqCount
