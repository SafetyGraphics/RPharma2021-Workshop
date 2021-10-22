# Exercise 4.1 Solution - Initialize the app with all custom/experimental charts from safetyCharts included. 
# Hint: Check out the `order` value in `?makeChartConfig`
library(safetyGraphics)
allCharts<-makeChartConfig() %>% 
purrr::map(function(chart){
    chart$order <- 1
    return(chart)
})
safetyGraphicsApp(charts=allCharts)

# Exercise 4.2 Solution - Convert the following static chart to run in the safetyGraphics app. Make sure that it works when custom data sets and mappings are provided.
# Bonus - Normalize the data and plot the results using a standardized y-axis.
library(safetyGraphics)
library(tidyverse)
labsBoxplot <- function(data,settings){
  p<-ggplot(
    data = data, 
    aes(x = .data[[settings$measure_col]], y = .data[[settings$value_col]])
  ) +
    geom_boxplot(fill ='blue') +
    scale_y_log10() +
    theme_bw() +
    theme(
      axis.text.x = element_text(angle = 25, hjust = 1), 	
      axis.text = element_text(size = 12), 
      axis.title = element_text(size = 12)
    )
  return(p)
}

labBoxplotConfig<-list(
  env="safetyGraphics",
  name="labBoxPlot",
  label="Lab Box Plot",
  type="plot",
  domain="labs",
  workflow=list(
    main="labsBoxplot"
  )
)

charts<-list(labsBoxplot=prepareChart(labBoxplotConfig))
safetyGraphicsApp(
  charts=charts, 
  domainData=list(labs=safetyData::adam_adlbc)
)

# Also confirm that the chart runs for: 

safetyGraphicsApp(charts=charts, domainData=list(labs=safetyData::sdtm_lb))

