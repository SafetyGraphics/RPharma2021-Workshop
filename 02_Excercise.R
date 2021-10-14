# Excercise 1 - Configure safetyGraphics for use with a non-standard labs dataset. Using the following steps: 
# 1. Start the app using the `labs` data loaded below. 
# 2. Select appropriate columns for each dropdown in the `mapping` tab. (Ignore the last 4 selections related to Baseline and Analysis)
# 3. Make sure the charts are rendering as expected.
# 4. Export code for the custom mapping from the code tab on the settings page
# 5. Restart the app using the custom mapping. Hint: You will probably want to use yaml::read_yaml, perhaps with the `text` parameter. 
# 6. Confirm that the mappings are automatically filled in and all charts work as expected.

########################## Excercise 1 Solution ##########################
library(yaml)
labs <- read.csv("https://raw.githubusercontent.com/SafetyGraphics/SafetyGraphics.github.io/master/pilot/SampleData_NoStandard.csv")
mapping<-read_yaml(text="labs:
  id_col: ID
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
")

safetyGraphicsApp(
    domainData=list(labs=labs),
    mapping=mapping
)

########################## End Excercise 1 Solution ##########################


# Bonus Excercise 1a - Export the code for the hepatic explorer and run the chart as a standalone graphic using htmlwidgets.
# Bonus Excercise 1b - Update the exported code for the hepatic explorer settings to use a custom title. To learn more about custom settings, click "wiki" in the chart header "configuration" and look for settings.title (or just use this link - https://github.com/SafetyGraphics/hep-explorer/wiki/Configuration#settingstitle)

########################## Bonus Excercise 1a & 1b Solution ##########################
# For 1a, paste directly from the "download code" button on the Charts/Hepatic Explorer page in the app from the code above. Only needed update is to change the data on line 55
# Additional customizastion for 1b is done in the last line of the mapping_yaml definition on line 77 below. 

library(yaml)
library(safetyCharts)

### Reproducible Code for Hepatic Safety Explorer (htmlwidget) ###

#Load Data
#NOTE: Correct data names should be updated by user
data<-labs

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