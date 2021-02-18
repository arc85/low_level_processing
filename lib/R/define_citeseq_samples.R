##Generate CSV to create alignment array for CITEseq
##TC Feb 18 2021

dat <- read.csv("./input_files/sample_info_sheet.csv")
dat.citeseq <- as.character(dat[dat$CITESEQ=="YES","Sample"])
write.table(dat.citeseq,file="./input_files/citeseq_samples_for_array.csv",row.names=FALSE,quote=FALSE,sep=",",col.names=F)
