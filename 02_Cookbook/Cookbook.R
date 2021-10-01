# Examples from the safetyGraphics Cookbook Vignette
# https://github.com/SafetyGraphics/safetyGraphics/wiki/Cookbook

# Installation
install.packages("safetyGraphics")
library("safetyGraphics")
library("tidyverse")

# Example 0 - Initialization GUI
safetyGraphics::safetyGraphicsInit()

# Example 1 - Default App
safetyGraphics::safetyGraphicsApp()

# Example 2 - SDTM Data
sdtm <- list(
  dm=safetyData::sdtm_dm,
  aes=safetyData::sdtm_ae,
  labs=safetyData::sdtm_lb
)
safetyGraphics::safetyGraphicsApp(domainData=sdtm)

# Example 3 - Lab data only
justLabs <- list(labs=safetyData::adam_adlbc)
safetyGraphics::safetyGraphicsApp(domainData=justLabs)

# Example 4 - Drop unwanted charts
library(purrr)
charts <- makeChartConfig() #gets charts from safetyCharts pacakge by default
notWidgets <- charts %>% purrr::keep(~.x$type != "htmlwidget")
safetyGraphicsApp(charts=notWidgets)

#Example 6 - Custom Chart
ageDist <- function(data, settings){
  p<-ggplot(
    data = data, 
    aes_(x=as.name(settings$age_col))
  ) +
    geom_histogram() + 
    facet_wrap(as.name(settings$sex_col))
  return(p)
}

ageDist_chart<-list(
  env="safetyGraphics",
  name="ageDist",
  label="Age Distribution",
  type="plot",
  domain="dm",
  workflow=list(
    main="ageDist"
  )
)
charts <- makeChartConfig() 
charts$ageDist<-ageDist_chart
safetyGraphicsApp(charts=charts)

# Example 6 - Non-standard data
notAdAM <- list(labs=safetyData::adam_adlbc %>% rename(id = USUBJID))
idMapping<- list(labs=list(id_col="id"))
safetyGraphicsApp(domainData=notAdAM, mapping=idMapping)

# Example 8 - Non-standard data #2
labs <- read.csv("https://raw.githubusercontent.com/SafetyGraphics/SafetyGraphics.github.io/master/pilot/SampleData_NoStandard.csv")
safetyGraphics::safetyGraphicsApp(domainData=list(labs=labs))