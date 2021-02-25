##TC Generation of CB Whitelists for each sample
##Feb 18 2021

#Read in external arguements
cli <- commandArgs(trailingOnly=T)
args <- strsplit(cli,"=",fixed=T)
overall.folder <- args[[1]][2]
fastq.folder <- args[[2]][2]
flowcell <- args[[3]][2]
mat.folder <- args[[4]][2]
citeseq.folder <- args[[5]][2]

.libPaths("/ihome/tbruno/arc85/Rlibs_Oct_2019")
library(Seurat)

sample.info.sheet <- read.csv("./input_files/sample_info_sheet.csv")
citeseq.samples <- as.character(sample.info.sheet[sample.info.sheet$CITESEQ=="YES","Sample"])

gex.samples <- gsub("_CITEseq","",citeseq.samples)

files.to.process <- paste(overall.folder,mat.folder,gex.samples,"outs","filtered_feature_bc_matrix",sep="/"))

dat <- vector("list",length=length(files.to.process))

for (i in 1:length(files.to.process)) {
	dat[[i]] <- Read10X(files.to.process)
}

meta.list <- vector("list",length=length(files.to.process))

for (i in 1:length(files.to.process)) {

		meta.list[[i]] <- data.frame(sample_id=rep(gex.samples[i],ncol(dat[[i]])))
		rownames(meta.list[[i]]) <- colnames(dat[[i]])

}

ser.list <- vector("list",length=length(files.to.process))

for (i in 1:length(files.to.process)) {

	ser.list[[i]] <- CreateSeuratObject(dat[[i]],meta.data=meta.list[[i]])

}

names(ser.list) <- gex.samples

ser.names <- lapply(ser.list,function(x) {

		colnames(x)

})

names(ser.names) <- citeseq.samples

dir.create(paste(overall.folder,citeseq.folder,"whitelists",sep="/"))

for (i in 1:length(ser.names)) {

	write.table(ser.names[[i]],file=paste(overall.folder,citeseq.folder,"whitelists",
	names(ser.names)[i],".csv",sep=""),
	quote=F,row.names=F,col.names=F,sep=",")

}
