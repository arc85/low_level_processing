##Generate sample sheet for bcl2fastq
##TC Jul 12 2020

#Read in external arguements
cli <- commandArgs(trailingOnly=T)
args <- strsplit(cli,"=",fixed=T)
flow.cell <- args[[1]][2]
overall.folder <- args[[2]][2]

library(tidyverse)

#Read in all sets of indices

dual.nn.kit <- read.csv("./input_files/Dual_Index_Kit_NN_Set_A.csv")
colnames(dual.nn.kit) <- c("index","set1","set2","set3")

dual.nt.kit <- read.csv("./input_files/Dual_Index_Kit_NT_Set_A.csv")
colnames(dual.nt.kit) <- c("index","set1","set2","set3")

dual.tt.kit <- read.csv("./input_files/Dual_Index_Kit_TT_Set_A.csv")
colnames(dual.tt.kit) <- c("index","set1","set2","set3")

dual.tn.kit <- read.csv("./input_files/Dual_Index_Kit_TN_Set_A.csv")
colnames(dual.tn.kit) <- c("index","set1","set2","set3")

dual.comb.kit <- do.call(rbind,list(dual.nn.kit,dual.nt.kit,dual.tt.kit,dual.tn.kit))
## Note: dual combo kits always use set1, but use EITHER set2 OR set3
## Depends on the version of the NovaSeq6000 kit used
## The indices are reverse compliments
## check out https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/bcl2fastq-direct
## For more info
dual.comb.kit <- dual.comb.kit[,c(1,2,4)]

#Read in simple sample sheet

simple.sample <- read.csv("./input_files/sample_info_sheet.csv")
simple.sample <- simple.sample[,1:3]
redo.lanes <- strsplit(as.character(simple.sample$Lane),split="-")
lanes <- rep(redo.lanes[[1]][1]:redo.lanes[[1]][2],each=1)

#Split up samples

sample.list <- simple.sample %>% group_split(Sample)
sets <- vector("list",length=length(sample.list))

#Build sample sheet

for (i in 1:length(sample.list)) {

	test.match <- dual.comb.kit$index %in% sample.list[[i]]$Index

	if (any(test.match)) {
		sequences <- as.matrix(dual.comb.kit[test.match,2:3]) %>% as.character
	} else {
		print("Error: Indices are not present in the reference sample sheets.")
		print("Recommend checking indices on sample sheet")
	}

	sets[[i]] <- data.frame(Lane=lanes,SampleID=sample.list[[i]]$Index,SampleName=sample.list[[i]]$Sample,index=sequences[1],index2=sequences[2],Sample_Project=flow.cell)

}

sample.sheet <- do.call(rbind,sets)

#Write sample sheet
file.name <- paste(overall.folder,"_sample_sheet.csv",sep="")

writeLines("[Header],,,,\nEMFileVersion,4,,,\n[Reads],,,,\n28,,,,\n90,,,,\n[Data],,,,\nLane,Sample_ID,Sample_Name,index,index2,Sample_Project",file.name)
write.table(sample.sheet,file=file.name,append=T,quote=F,sep=",",row.names=F,col.names=F)
