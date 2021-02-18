##Generate CSV to create alignment array for TCR and BCR
##TC Feb 18 2021

dat <- read.csv("./input_files/sample_info_sheet.csv")
dat.tcrbcr <- as.character(dat[dat$TCR_BCR=="YES","Sample"])
write.table(dat.tcrbcr,file="./input_files/tcr_bcr_samples_for_array.csv",row.names=FALSE,quote=FALSE,sep=",",col.names=F)
