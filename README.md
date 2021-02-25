# Low-level processing of scRNAseq data from 10X and Illumina
## Updated February 18, 2021

This goal of this pipeline is to facilitate reproducible processing of 10X Genomics data through a standardized workflow.

## Distinct stages of processing

1. Download raw sequencing data, check MD5sums, untar, run bcl2fastq
2. Create SLURM array for GEX alignment
3. Create SLURM array for CITEseq alignment
4. Create SLURM array for TCR/BCR alignment

## February 18, 2021 changes

1. Refactoring of the code into distinct stages, separating binaries into bin and R scripts into lib/R
2. Creating the following input files:
    1. variable_names.csv - create environment variables from specified names
    2. sample_info_sheet.csv - specify the types of libraries (i.e. GEX, CITEseq, TCR/BCR) and the references that should be used for each
    3. Update citeseq tags - 10 human and 10 murine in one list, separate list of a large CITEseq panel of surface antibodies

## Future features to create

1. Creating a report after all stages have been run that aggregates web summaries from CellRanger and run info from CITEseqCount
