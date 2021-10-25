# Example 5.1 - Make a vital signs domain based on the existing labs domain ... with no charts?!
library("safetyGraphics")
library("tidyverse")

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

# Example 5.2 - Add brand new Hello World data domain ... with an awesome custom chart!!
library(safetyGraphics)
library(tidyverse)

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

# Example 5.3 - Define an ECG data ... and adapt an existing chart for usage there.
# See this PR for a full implementation of the ECG domain in safetyCharts - https://github.com/SafetyGraphics/safetyCharts/pull/90
library(safetyGraphics)
library(yaml)
library(tidyverse)
adeg <- readr::read_csv("https://physionet.org/files/ecgcipa/1.0.0/adeg.csv?download")

ecg_meta <-tibble::tribble(
     ~text_key, ~domain,                      ~label,                               ~description, ~standard_adam, ~standard_sdtm,
      "id_col",   "ecg",                 "ID column", "Unique subject identifier variable name.",      "USUBJID",      "USUBJID",
   "value_col",   "ecg",              "Value column",                 "QT result variable name.",         "AVAL",     "EGSTRESN",
 "measure_col",   "ecg",            "Measure column",                 "QT measure variable name",        "PARAM",       "EGTEST",
"studyday_col",   "ecg",          "Study Day column",                  "Visit day variable name",          "ADY",         "EGDY",
   "visit_col",   "ecg",              "Visit column",                      "Visit variable name",         "ATPT",        "EGTPT",
  "visitn_col",   "ecg",       "Visit number column",               "Visit number variable name",        "ATPTN",             NA,
  "period_col",   "ecg",             "Period column",                     "Period variable name",      "APERIOD",             NA,
    "unit_col",   "ecg",               "Unit column",            "Unit of measure variable name",        "AVALU",     "EGSTRESU"
) %>% mutate(
    col_key = text_key,
    type="column"
)

qtOutliers<-read_yaml('https://raw.githubusercontent.com/SafetyGraphics/safetyCharts/dev/inst/config/safetyOutlierExplorer.yaml') 
qtOutliers$label <- "QT Outlier explorer"
qtOutliers$domain <- "ecg"

safetyGraphicsApp(
    meta=ecg_meta, 
    domainData=list(ecg=adeg), 
    charts=list(prepareChart(qtOutliers))
)

