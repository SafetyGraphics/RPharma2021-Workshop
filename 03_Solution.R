# Excercise 3.1 - Export the code for the hepatic explorer and run the chart as a standalone graphic. Use the same custom data loaded in `Ex2_1.R`
# Bonus - Update the exported code for the hepatic explorer settings to use a custom title. To learn more about custom settings, click "wiki" in the chart header "configuration" and look for settings.title (or just use this link - https://github.com/SafetyGraphics/hep-explorer/wiki/Configuration#settingstitle). 
# Double Mega Bonus - Try other customizations. Simulate a treatment arm, and then use it as a grouping variable.

########################## Bonus Excercise 3.1 Solution + Bonus ##########################
# Paste directly from the "download code" button on the Charts/Hepatic Explorer page in the app you created in Ex2_1. Only needed update is to change the data on line 15. 
# Additional customizastion for the bonus is done in the last line of the mapping_yaml definition on line 37 below. 

library(yaml)
library(safetyCharts)

### Reproducible Code for Hepatic Safety Explorer (htmlwidget) ###

#Load Data
#NOTE: Correct data names should be updated by user
data<- read.csv("https://raw.githubusercontent.com/SafetyGraphics/SafetyGraphics.github.io/master/pilot/SampleData_NoStandard.csv")

#Load mapping
#NOTE: mapping can also be saved as a .yaml and used for multiple charts.
mapping_yaml<-"id_col: ID
value_col: LBSTRESN
measure_col: LBTEST
measure_values:
  ALT: Aminotransferase, alanine (ALT)
  AST: Aminotransferase, aspartate (AST)
  TB: Total Bilirubin
  ALP: Alkaline phosphatase (ALP)
normal_col_low: LBSTNRLO
normal_col_high: LBSTNRHI
studyday_col: LBDY
visit_col: VIS
visitn_col: VISN
unit_col: LBSTRESU
baseline_flag_col: ''
baseline_flag_values: ''
analysis_flag_col: ''
analysis_flag_values: ''
title: 'Sweet Custom Title'
"
mapping <- read_yaml(text=mapping_yaml)

# Create Parameter list
params<-list(data=data, settings=mapping)

widgetParams <- list(
    name='hepExplorer',
    package='safetyCharts',
    sizingPolicy = htmlwidgets::sizingPolicy(viewer.suppress=TRUE, browser.external = TRUE),
    x=list()
)
widgetParams$x$data <- params$data
widgetParams$x$rSettings <- params$settings
widgetParams$x$settings <- jsonlite::toJSON(
    params$settings,
    auto_unbox = TRUE,
   null = "null"
)
params <- widgetParams

# Run the chart
do.call(htmlwidgets::createWidget,params)
########################## End Bonus Excercise 1a & 1b Solution ##################################