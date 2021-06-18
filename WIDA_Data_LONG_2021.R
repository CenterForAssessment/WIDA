####################################################################################
###                                                                              ###
###    Script to create LONG data file from multiple WIDA states for 2021        ###
###                                                                              ###
####################################################################################

### Load packages
require(data.table)

### Load Data
load("Data/Base_Files/WIDA_CO_Data_LONG_2021.Rdata")
load("Data/Base_Files/WIDA_HI_Data_LONG_2021.Rdata")
load("Data/Base_Files/WIDA_IN_Data_LONG_2021.Rdata")

### Combine data sets
variables.to.keep <- c("VALID_CASE", "ID", "GRADE", "YEAR", "CONTENT_AREA", "SCALE_SCORE")
WIDA_Data_LONG_2021 <- rbindlist(list(
                    WIDA_CO_Data_LONG_2021[,variables.to.keep, with=FALSE][,WIDA_STATE:="CO"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_HI_Data_LONG_2021[,variables.to.keep, with=FALSE][,WIDA_STATE:="HI"][,ID:=paste(ID, WIDA_STATE, sep="_")],
                    WIDA_IN_Data_LONG_2021[,variables.to.keep, with=FALSE][,WIDA_STATE:="IN"][,ID:=paste(ID, WIDA_STATE, sep="_")]
))

setkey(WIDA_Data_LONG_2021, VALID_CASE, CONTENT_AREA, YEAR, ID)

### Tidy up data set
WIDA_Data_LONG_2021 <- WIDA_Data_LONG_2021[VALID_CASE=="VALID_CASE"]

### Save Results
save(WIDA_Data_LONG_2021, file="Data/WIDA_Data_LONG_2021.Rdata")
