
# Installation
library("safetyGraphics")
library("tidyverse")

# Example 5.1 - Make a vital signs domain based on the existing labs domain ... with no charts?!
vitalsMeta <- safetyGraphics::meta %>%
filter(domain == 'labs') %>% 
mutate(domain='vitals')

newMeta <- rbind(safetyGraphics::meta, vitalsMeta)

sdtm <- list(
    dm=safetyData::sdtm_dm,
    aes=safetyData::sdtm_ae,
    labs=safetyData::sdtm_lb,
    vitals= safetyData::sdtm_vs
)

safetyGraphics::safetyGraphicsApp(domainData=sdtm, meta=newMeta)

# Example 5.2 - Add brand new Hello World data domain ... with an awesome custom chart

helloMeta <- tribble(
  ~text_key, ~domain, ~label,       ~standard_hello, ~description,
  "x_col",   "hello", "x position", "x",             "x position for points in hello world chart",   
  "y_col",   "hello", "y position", "y",             "y position for points in hello world chart"   
) %>% mutate(
    col_key = text_key,
    type="column"
)

detectStandard(domain='hello', data = iris, meta=helloMeta)

helloData<-data.frame(x=runif(50, -1,1), y=runif(50, -1,1))

helloWorld <- function(data, settings){
    plot(-1:1, -1:1)
    text(data[[settings$x_col]], data[[settings$y_col]], "Custom Hello Domain!")
}

# Chart Configuration
helloChart<-prepareChart(
    list(
        env="safetyGraphics",
        name="HelloWorld",
        label="Hello World!",
        type="plot",
        domain="hello",
        workflow=list(
            main="helloWorld"
        )
    )
)

safetyGraphicsApp(
    meta=helloMeta, 
    domainData=list(hello=helloData), 
    charts=list(helloChart)
)

# Example 5.3 - Recreate the safetyOutlierExplorer Chart using ECG data
adeg <- readr::read_csv("https://physionet.org/files/ecgcipa/1.0.0/adeg.csv?download")
ecg_meta <- meta
qtOutlierExplorerChart <- prepareChart('')

# See this PR for a full implementation of the ECG domain in safetyCharts - 


