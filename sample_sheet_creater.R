##Generate sample sheet for bcl2fastq
##TC March 23 2020

#Read in external arguements
cli <- commandArgs(trailingOnly=T)
args <- strsplit(cli,"=",fixed=T)
flow.cell <- args[[1]][2]
overall.folder <- args[[2]][2]

.libPaths("/ihome/tbruno/arc85/Rlibs_Oct_2019")
library(tidyverse)

#Read in indices

si.ga.indices <- read.csv("./ancillary_files/chromium-shared-sample-indexes-plate.csv",header=F)
colnames(si.ga.indices) <- c("index","set1","set2","set3","set4")

si.na.indices <- read.csv("./ancillary_files/Chromium-i7-Multiplex-Kit-N-Set-A-sample-indexes-plate.csv",header=F)
colnames(si.na.indices) <- c("index","set1","set2","set3","set4")


#Read in simple sample sheet

simple.sample.sheet <- paste("./ancillary_files/","novaseq_run5_simple_sample.csv",sep="")
simple.sample <- read.csv(simple.sample.sheet)
redo.lanes <- strsplit(as.character(simple.sample$Lane),split="-")
lanes <- rep(redo.lanes[[1]][1]:redo.lanes[[1]][2],each=4)


#Split up samples

sample.list <- simple.sample %>% group_split(Sample)
sets <- vector("list",length=length(sample.list))


#Build sample sheet

for (i in 1:length(sample.list)) {

	test.match <- si.ga.indices$index %in% sample.list[[i]]$Index

	if (any(test.match)) {
		sequences.index <- si.ga.indices$index %in% sample.list[[i]]$Index
		sequences <- as.matrix(si.ga.indices[sequences.index,2:5]) %>% as.character
	} else {
		sequences.index <- si.na.indices$index %in% sample.list[[i]]$Index
		sequences <- as.matrix(si.na.indices[sequences.index,2:5]) %>% as.character
	}

	sets[[i]] <- data.frame(Lane=lanes,SampleID=sample.list[[i]]$Index,SampleName=sample.list[[i]]$Sample,index=sequences,Sample_Project=flow.cell)

}

sample.sheet <- do.call(rbind,sets)


#Write sample sheet
file.name <- paste(overall.folder,"_sample_sheet.csv",sep="")

writeLines("[Header],,,,\nEMFileVersion,4,,,\n[Reads],,,,\n28,,,,\n91,,,,\n[Data],,,,\nLane,Sample_ID,Sample_Name,index,Sample_Project",file.name)
write.table(sample.sheet,file=file.name,append=T,quote=F,sep=",",row.names=F,col.names=F)
