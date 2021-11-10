# Processing of scRNAseq data from 10X
## Updated November 10, 2021

This goal of this pipeline is to facilitate reproducible processing of 10X Genomics data through a standardized workflow. Why isn't this working.

## Distinct stages of processing

1. Download raw sequencing data, check MD5sums, untar, run bcl2fastq
2. SLURM array for GEX alignment
3. SLURM array for CITEseqCount (dependent on completion of stage 2)
4. SLURM array for TCR/BCR alignment (independent of stages 2 and 3)

## November 10, 2021 changes

1. Update read structure in bcl2fastq for dual indices
2. Specify sample_sheet_creator_dual_index.R for dual index sample sheet creation

## Future features

1. Build capacity for multiome (i.e. paired scRNAseq and paired scATACseq) analysis - cellranger ARC required
2. Automate backup to Pitt Box and/or AWS
3. Aggregate web summaries from GEX and TCR/BCR alignment and run_info from CITEseqCount
