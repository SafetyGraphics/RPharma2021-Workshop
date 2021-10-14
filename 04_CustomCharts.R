# Examples from the safetyGraphics Cookbook Vignette
# https://github.com/SafetyGraphics/safetyGraphics/wiki/Cookbook

# Installation
install.packages("safetyGraphics")
library("safetyGraphics")
library("tidyverse")

# Example 4.1 - Drop unwanted Charts
library(purrr)
charts <- makeChartConfig() #gets charts from safetyCharts pacakge by default
notWidgets <- charts %>% purrr::keep(~.x$type != "htmlwidget")
safetyGraphicsApp(charts=notWidgets)

# Try 04_Excercise1.R now!

# Example 4.2 - Hello World
helloWorld <- function(data, settings){
    plot(-1:1, -1:1)
    text(runif(20, -1,1),runif(20, -1,1),"Hello World")
}

# Chart Configuration
helloworld_chart<-list(
    env="safetyGraphics",
    name="HelloWorld",
    label="Hello World!",
    type="plot",
    domain="aes",
    workflow=list(
        main="helloWorld"
    )
)

safetyGraphicsApp(charts=list(helloworld_chart))

# Example 4.3 - Simple custom Chart using data and settings
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

# Example 4.4 - Custom static outlier explorer

spaghettiPlot <- function( data, settings ){
    # define plot aes - note use of standard evaluation! 
    plot_aes <- aes_(
        x=as.name(settings$studyday_col), 
        y=as.name(settings$value_col), 
        group=as.name(settings$id_col)
    )

    #create the plot
    p<-ggplot(data = data, plot_aes) +
        geom_path(alpha=0.15) + 
        facet_wrap(
            as.name(settings$measure_col),
            scales="free_y"
        )
    return(p)
}

spaghettiConfig <- read.yaml(text="env: safetyGraphics
label: Spaghetti Plot
name: spaghettiPlot
type: plot
domain: 
  - labs
workflow:
  main: spaghettiPlot
links:
  safetyCharts: https://github.com/SafetyGraphics/safetycharts
")

charts <- makeChartConfig()
charts$spaghetti<-prepareChart(read_yaml(text=spaghettiConfig))
safetyGraphicsApp(charts=charts)

# Example 4.5 - Custom shiny module

safetyOutlierExplorer_ui <- function(id) {
    ns <- NS(id) 
    sidebar<-sidebarPanel(
        selectizeInput(
            ns("measures"), 
            "Select Measures", 
            multiple=TRUE, 
            choices=c("")
        )
    )
    main<-mainPanel(plotOutput(ns("outlierExplorer")))
    ui<-fluidPage(
        sidebarLayout(
            sidebar,
            main,
            position = c("right"),
            fluid=TRUE
        )
    )
    return(ui)
}

safetyOutlierExplorer_server <- function(input, output, session, params) {

    ns <- session$ns
    # Populate control with measures and select all by default
    observe({
        measure_col <- params()$settings$measure_col
        measures <- unique(params()$data[[measure_col]])
        updateSelectizeInput(
            session, 
            "measures",
            choices = measures,
            selected = measures
        )
    })

    # customize selected measures based on input
    settingsR <- reactive({
        settings <- params()$settings
        settings$measure_values <- input$measures
        return(settings)
    })

    #draw the chart
    output$outlierExplorer <- renderPlot({safety_outlier_explorer(params()$data, settingsR())})
}

outlierMod <- "env: safetyGraphics
label: Outlier Explorer - Module
name: outlierExplorerMod
type: module
package: safetyCharts
domain: 
  - labs
workflow:
  ui: safetyOutlierExplorer_ui
  server: safetyOutlierExplorer_server
links:
  safetyCharts: https://github.com/SafetyGraphics/safetycharts
"

charts <- makeChartConfig()
charts$outlierMod<-prepareChart(read_yaml(text=outlierMod))
safetyGraphicsApp(charts=charts)
