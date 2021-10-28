# Exercise 4.2 - Convert the following static chart to run in the safetyGraphics app. Make sure that it works when custom data sets and mappings are provided.
# For details about the settings for the labs domain see: View(safetyGraphics::meta %>% filter(domain=="labs")) 
# To access the current value for a setting use the `text_key`. for example, settings$id_col would give the current value for the ID column.


# Bonus - Normalize the data and plot the results using a standardized y-axis! 

############ Static Example #################
labs_sub <- unique(safetyData::adam_adlbc$PARAM)[1:5]
ggplot(
	data = safetyData::adam_adlbc %>% filter(PARAM %in% labs_sub),
	aes(x = PARAM, y = AVAL)
) +
geom_boxplot(fill ="blue") +
scale_y_log10() +
theme_bw() +
theme(
    axis.text.x = element_text(angle = 40, hjust = 1), 	
    axis.text = element_text(size = 12), 
    axis.title = element_text(size = 12)
)
############ End of Static Example #############



###### Update the code below to deploy the static chart #######
# Re-usable chart function
# For details about the settings for the labs domain see: 
# View(safetyGraphics::meta %>% filter(domain=="labs")) 

labsBoxplot <- function(data,settings){
    ############ Add reusable chart code here! ################
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
charts<-list(prepareChart(labBoxplotConfig))
safetyGraphicsApp(charts=charts, domainData=list(labs=safetyData::adam_adlbc))

# Also confirm that the chart runs for SDTM data: 
safetyGraphicsApp(charts=charts, domainData=list(labs=safetyData::sdtm_lb))

