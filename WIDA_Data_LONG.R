####################################################################################
###                                                                              ###
###             Script to create LONG data file from multiple WIDA states        ###
###                                                                              ###
####################################################################################

### Load packages
require(data.table)

### Load Data
load("Data/Base_Files/WIDA_CO_SGP_LONG_Data.Rdata")
load("Data/Base_Files/WIDA_HI_SGP_LONG_Data.Rdata")
load("Data/Base_Files/WIDA_IN_SGP_LONG_Data.Rdata")
load("Data/Base_Files/WIDA_MA_SGP_LONG_Data.Rdata")
load("Data/Base_Files/WIDA_NH_SGP_LONG_Data.Rdata")
load("Data/Base_Files/WIDA_RI_SGP_LONG_Data.Rdata")

### Combine data sets
variables.to.keep <- c("VALID_CASE", "ID", "GRADE", "YEAR", "CONTENT_AREA", "SCALE_SCORE")
WIDA_Data_LONG <- rbindlist(list(
                    WIDA_CO_SGP_LONG_Data[,variables.to.keep, with=FALSE][,WIDA_STATE:="CO"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_HI_SGP_LONG_Data[,variables.to.keep, with=FALSE][,WIDA_STATE:="HI"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_IN_SGP_LONG_Data[,variables.to.keep, with=FALSE][,WIDA_STATE:="IN"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_MA_SGP_LONG_Data[,variables.to.keep, with=FALSE][,WIDA_STATE:="MA"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_NH_SGP_LONG_Data[,variables.to.keep, with=FALSE][,WIDA_STATE:="NH"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_RI_SGP_LONG_Data[,variables.to.keep, with=FALSE][,WIDA_STATE:="RI"][,ID:=paste(ID, WIDA_STATE, sep="_")]
))

setkey(WIDA_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)

### Tidy up data set
WIDA_Data_LONG <- WIDA_Data_LONG[VALID_CASE=="VALID_CASE"]
for (grade.iter in as.character(0:12)) {
    tmp.loss.hoss <- SGP::SGPstateData[['WIDA']][['Achievement']][['Knots_Boundaries']][['READING.2016']][[paste('loss.hoss', grade.iter, sep="_")]]
    WIDA_Data_LONG[GRADE==grade.iter & SCALE_SCORE < tmp.loss.hoss[1], SCALE_SCORE:=tmp.loss.hoss[1]]
    WIDA_Data_LONG[GRADE==grade.iter & SCALE_SCORE > tmp.loss.hoss[2], SCALE_SCORE:=tmp.loss.hoss[2]]
}

### Save Results
save(WIDA_Data_LONG, file="Data/WIDA_Data_LONG.Rdata")
