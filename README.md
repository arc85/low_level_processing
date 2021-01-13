# Low-level processing of scRNAseq data from 10X and Illumina

Updated July 13, 2020

This pipeline is a work in progress, with the goal being to facilitate ease of processing for 10X Genomics data through a standardized workflow.

Currently, the pipeline will run from the wrapper through the alignment of gene expression matrices. Critical input files are specificed in the ancillary files. Specifically:

  "02_run_download.sh" depends on the specific file structure in "./ancillary_files/Download_Links.csv". This assumes that the run will be downloaded from e.g. DNA Nexus.

  "07_define_align_array.sh" depends on sample names specified in "./ancillary_files/xxx_simple_sample.csv". Files with specific strings (identified by grep) are excluded from the gene expression alignment array. Specifically, lines with the following strings are excluded:

    1. "hash" indicates cell hashing libraries
    2. "TCR" indiciates TCR sequencing libraries
    3. "BCR" indiciates BCR sequencing libraries

Future directions include:

  1. Include different alignment scripts for human and murine data.
  2. Changing "08_align.sbatch" to run "09_copy_summaries.sh" whenever the array completes.
  3. Run CITEseq count automatically on samples that contain cell hashing and/or CITEseq data
