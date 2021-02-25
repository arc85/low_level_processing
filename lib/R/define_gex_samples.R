##Generate CSV to create alignment array for GEX
##TC Feb 18 2021

dat <- read.csv("./input_files/sample_info_sheet.csv")
dat.gex <- as.character(dat[dat$GEX=="YES","Sample"])
write.table(dat.gex,file="./input_files/gex_samples_for_array.csv",row.names=FALSE,quote=FALSE,sep=",",col.names=F)
