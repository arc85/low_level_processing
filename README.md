# Low-level processing of scRNAseq data from 10X and Illumina

Updated January 13, 2021

This pipeline is a work in progress, with the goal being to facilitate ease of processing for 10X Genomics data through a standardized workflow.

Currently, the pipeline will run from the wrapper through the alignment of gene expression and VDJ FASTQ files. Critical input files are specificed in the ancillary files. Specifically:

  "02_run_download.sh" depends on the specific file structure in "./ancillary_files/Download_Links.csv". This assumes that the run will be downloaded from e.g. DNA Nexus.

  "07_define_align_array.sh" depends on sample names specified in "./ancillary_files/xxx_simple_sample.csv". Files with specific strings (identified by grep) are excluded from the gene expression alignment array. Specifically, lines with the following strings are excluded:

    1. "Hash" or "hash" or "CITEseq" indicates cell hashing and/or CITEseq libraries
    2. "TCR" indiciates TCR sequencing libraries
    3. "BCR" indiciates BCR sequencing libraries

January 13, 2021 changes:

  1. Changing "05_mkfastq.sbatch" to use srun instead of sbatch so that the pipeline runs uninterrupted.
  2. Adding "08_align_tcr_bcr.sbatch" to align VDJ FASTQ

Future changes will include:

  1. Run CITEseq count automatically on samples that contain cell hashing and/or CITEseq data
  2. 
