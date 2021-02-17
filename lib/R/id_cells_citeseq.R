##TC Generation of CB Whitelists for each sample
##March 31 2020

.libPaths("/ihome/tbruno/arc85/Rlibs_Oct_2019")
library(Seurat)

null.path <- getwd()
files.to.process <- list.files()
files.to.process <- files.to.process[grep(".out|.sbatch",files.to.process,invert=T)]

paths <- paste(null.path,files.to.process,"outs","filtered_feature_bc_matrix",sep="/")

dat <- Read10X(paths)

meta.list <- vector("list",length=length(files.to.process))
for (i in 1:length(files.to.process)) {
	if (i==1) {
		meta.list[[i]] <- rep(files.to.process[i],length(grep("^[A-z]",colnames(dat))))
	} else {
		meta.list[[i]] <- rep(files.to.process[i],length(grep(paste("^",i,sep=""),colnames(dat))))
	}
}
meta <- data.frame(sample=Reduce(c,meta.list))
rownames(meta) <- colnames(dat)

ser <- CreateSeuratObject(dat,meta.data=meta)
ser.split <- SplitObject(ser,split.by="sample")

ser.names <- lapply(ser.split,function(x) {

	if (length(grep("^[A-z]",colnames(x)))>0) {
		colnames(x)
	} else {
		sapply(strsplit(as.character(colnames(x)),split="_"),function(x) x[2])
	}

})

names(ser.names) <- names(ser.split)

setwd("/zfs1/tbruno/arc85/0_INBOX/novaseq3_fastq/novaseq_run3/outs/fastq_path/HM2JGDMXX")

cell.hash.samples <- list.files()
cell.hash.samples <- cell.hash.samples[grep("Hash",cell.hash.samples)]
temp <- lapply(strsplit(cell.hash.samples,split="_"),function(x) grep("Cell|Hash",x,invert=T,value=T))
cell.hash.samples <- sapply(temp,function(x) paste(x,collapse="_"))

ser.names <- ser.names[names(ser.names) %in% cell.hash.samples]

setwd("/zfs1/tbruno/arc85/0_INBOX/novaseq3_citeseq/whitelists")

for (i in 1:length(ser.names)) {

	write.table(ser.names[[i]],paste(names(ser.names)[i],"_Cell_Hash",".csv",sep=""),quote=F,row.names=F,col.names=F,sep=",")

}
