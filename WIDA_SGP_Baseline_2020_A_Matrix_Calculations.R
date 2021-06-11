########################################################################
###                                                                  ###
###       WIDA Learning Loss Analyses -- Create Baseline Matrices    ###
###                                                                  ###
########################################################################

### Load necessary packages
require(SGP)

###   Load data from the 'official' 2020 SGP analyses
load("Data/WIDA_Data_LONG.Rdata")

### NULL out existing baseline matrices (that never get used anyway)
SGPstateData[["WIDA"]][["Baseline_splineMatrix"]] <- NULL

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2020/BASELINE/Matrices/READING.R")

WIDA_BASELINE_CONFIG <- READING_BASELINE.config

###   Create Baseline Matrices
WIDA_SGP <- prepareSGP(WIDA_Data_LONG, create.additional.variables=FALSE)

WIDA_Baseline_Matrices <- baselineSGP(
				WIDA_SGP,
				sgp.baseline.config=WIDA_BASELINE_CONFIG,
				return.matrices.only=TRUE,
				calculate.baseline.sgps=FALSE,
				goodness.of.fit.print=FALSE,
				parallel.config = list(
					BACKEND="PARALLEL", WORKERS=list(TAUS=4))
)

###   Save results
save(WIDA_Baseline_Matrices, file="Data/WIDA_Baseline_Matrices.Rdata", compress="xz")
