# Installation
library("safetyGraphics")

# Example 1.1 - Default App
safetyGraphics::safetyGraphicsApp()

# Example 1.2 - Initialization GUI
labs <- safetyData::adam_adlbc
ae <- safetyData::adam_adae
dm <- safetyData::adam_adsl
safetyGraphics::safetyGraphicsInit()
