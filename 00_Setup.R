install.packages('devtools')
install.packages('tidyverse')
install.packages('safetyGraphics') 
devtools::install_github('safetyGraphics/safetyCharts@7c172364e7ca202ef1f2eb0ebffb4af0e6e5d397') #includes fixes after v0.2 CRAN release
install.packages('yaml') 
install.packages('haven')

library(tidyverse)
library(safetyGraphics)
library(yaml)
library(haven)

