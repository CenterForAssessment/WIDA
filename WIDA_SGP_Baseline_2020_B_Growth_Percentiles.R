###################################################################################
###                                                                             ###
###   WIDA Learning Loss Analyses -- 2020 Baseline Growth Percentiles           ###
###                                                                             ###
###################################################################################

###   Load packages
require(SGP)

###   Load data and remove years that will not be used.
load("Data/WIDA_Data_LONG.Rdata")

###   Add single-cohort baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA", "2021")

#####
###   Run BASELINE SGP analysis - create new WIDA_SGP object with historical data
#####

SGPstateData[["WIDA"]][["Assessment_Program_Information"]][["CSEM"]] <- NULL

WIDA_SGP <- abcSGP(
        sgp_object = WIDA_Data_LONG,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  baseline SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in next step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = list(
					BACKEND = "PARALLEL",
					WORKERS=list(BASELINE_PERCENTILES=8))
)

###   Save results
save(WIDA_SGP, file="Data/WIDA_SGP.Rdata")
