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

# Example 2.3 - Load SAS transport data 
# Import data using standard R workflows and then initialize the app. Similar logic applies for `.sas7bdat` files (and any other extensions).
xptLabs <- haven::read_xpt('https://github.com/phuse-org/phuse-scripts/blob/master/data/adam/cdiscpilot01/adlbc.xpt?raw=true')
safetyGraphics::safetyGraphicsApp(domainData=list(labs=xptLabs))

# Example 2.4 - Non-standard data
notAdAM <- list(labs=safetyData::adam_adlbc %>% rename(id = USUBJID))
idMapping<- list(labs=list(id_col="id"))
safetyGraphicsApp(domainData=notAdAM, mapping=idMapping)
