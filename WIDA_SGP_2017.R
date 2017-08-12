##########################################################################################
###
### Script for calculating SGP coefficient matrices for 2017 for WIDA/ACCESS
###
##########################################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/WIDA_Data_LONG.Rdata")


### Run analyses

WIDA_SGP <- abcSGP(
		WIDA_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE)


### Save results

save(WIDA_SGP, file="Data/WIDA_SGP.Rdata")


### Save coefficient matrices

WIDA_Cohort_Referenced_Matrices <- WIDA_SGP@SGP$Coefficient_Matrices
save(WIDA_Cohort_Referenced_Matrices, file="WIDA_Cohort_Referenced_Matrices.Rdata")
