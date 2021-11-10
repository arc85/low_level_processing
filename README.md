# Processing of scRNAseq data from 10X and Illumina
## Updated May 4, 2021

This goal of this pipeline is to facilitate reproducible processing of 10X Genomics data through a standardized workflow. Why isn't this working.

## Distinct stages of processing

1. Download raw sequencing data, check MD5sums, untar, run bcl2fastq
2. SLURM array for GEX alignment
3. SLURM array for CITEseqCount (dependent on completion of stage 2)
4. SLURM array for TCR/BCR alignment

## May 4, 2021 changes

1. Check format of input files and use sed or tr instead of dos2unix
1. Prevent automatic exit after MD5sum check of downloaded files - done
2. Refactoring of lib/R/sample_info_sheet.R to accomodate new indices from 10X
3. Modify 02_run_download.sh to not rely on dos2unix (use sed instead)
4. Add meaningful errors to check formatting of initial input files

## Future features to create

1. Build capacity for multiome (i.e. paired scRNAseq and paired scATACseq) analysis - cellranger ARC required
2. Automate backup to Pitt Box and/or AWS
3. Aggregate web summaries from GEX and TCR/BCR alignment and run_info from CITEseqCount
