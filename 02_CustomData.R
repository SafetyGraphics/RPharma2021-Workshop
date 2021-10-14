# Examples from the safetyGraphics Cookbook Vignette
# https://github.com/SafetyGraphics/safetyGraphics/wiki/Cookbook

# Installation
install.packages("safetyGraphics")
library("safetyGraphics")
library("tidyverse")

# Example 2.1 - SDTM Data
sdtm <- list(
    dm=safetyData::sdtm_dm,
    aes=safetyData::sdtm_ae,
    labs=safetyData::sdtm_lb
)
safetyGraphics::safetyGraphicsApp(domainData=sdtm)

# Example 2.2 - Lab data only
justLabs <- list(labs=safetyData::adam_adlbc)
safetyGraphics::safetyGraphicsApp(domainData=justLabs)

# Example 2.3 - Non-standard data
notAdAM <- list(labs=safetyData::adam_adlbc %>% rename(id = USUBJID))
idMapping<- list(labs=list(id_col="id"))
safetyGraphicsApp(domainData=notAdAM, mapping=idMapping)


