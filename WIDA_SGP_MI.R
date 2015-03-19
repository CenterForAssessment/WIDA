#########################################################################################
###
### Script to run WIDA baseline analyses
###
#########################################################################################

### Load SGP Package

require(SGP)
#debug(SGP:::getSGPConfig)
debug(analyzeSGP)


### Load data

load("/Users/damian/Documents/Github/WIDA_MI/Data/WIDA_MI_Data_LONG_2014.Rdata")


### Create config for 1 year projections

READING_2014.config <- list(
        READING.2014 = list(
                sgp.content.areas=rep('READING', 2),
                sgp.projection.content.areas='READING',
                sgp.panel.years=c('2013', '2014'),
                sgp.projection.panel.years='2014',
                sgp.grade.sequences=list(c('0', '1'), c('1', '2'), c('2', '3'), c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'), c('8', '9'), c('9', '10'), c('10', '11')),
                sgp.projection.grade.sequences=list('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')))

### Modify SGPstateData

SGPstateData[["WIDA_MI"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL
SGPstateData[["WIDA_MI"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"


### Run abcSGP

WIDA_MI_SGP_2014 <- abcSGP(
		WIDA_MI_Data_LONG_2014,
		years="2014",
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "visualizeSGP", "outputSGP"),
		sgp.percentiles=FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections=FALSE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		save.intermediate.results=TRUE,
		sgp.config=READING_2014.config,
		plot.types="growthAchievementPlot")

#visualizeSGP(WIDA_SGP, plot.types="growthAchievementPlot")
#visualizeSGP(WIDA_SGP, plot.types="growthAchievementPlot", gaPlot.start.points="Achievement Percentiles")

save(WIDA_MI_SGP_2014, file="Data/WIDA_MI_SGP_2014.Rdata")
