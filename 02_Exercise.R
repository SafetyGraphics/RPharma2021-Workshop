# Exercise 2 - Configure safetyGraphics for use with a non-standard labs dataset. Using the following steps: 
# 1. Start the app using the `labs` data loaded below. 
# 2. Select appropriate columns for each dropdown in the `mapping` tab. (Ignore the last 4 selections related to Baseline and Analysis)
# 3. Make sure the charts are rendering as expected.
# 4. Export code for the custom mapping from the code tab on the settings page
# 5. Restart the app using the custom mapping. Hint: You will probably want to use yaml::read_yaml, perhaps with the `text` parameter. 
# 6. Confirm that the mappings are automatically filled in and all charts work as expected.
library(safetyGraphics)
library(tidyverse)
labs <- read.csv("https://raw.githubusercontent.com/SafetyGraphics/SafetyGraphics.github.io/master/pilot/SampleData_NoStandard.csv")
