# Exercise 2 Solution - Configure safetyGraphics for use with a non-standard labs dataset. 
# Update the custom mapping based on the column names in the custom data set provided.
customLabs <- read.csv("https://raw.githubusercontent.com/SafetyGraphics/SafetyGraphics.github.io/master/pilot/SampleData_PartialADaM.csv")

customMapping<-list(
    labs=list(
        measure_values = list(
            TB = "Bilirubin (mg/dL)" # Enter the field value for Total Bilirubin
        ),
        normal_col_low="ANRLO", # Update the column for normal range lower limit ...
        normal_col_high="ANRHI" # ... and upper limit
    )
)

safetyGraphicsApp(
    domainData=list(labs=customLabs),
    mapping=customMapping
)