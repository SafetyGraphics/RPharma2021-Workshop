# RPharma2021-Workshop
Materials for the safetyGraphics R Phama 2021 Workshop

# Outline

1. Presentation - Intro To safetyGraphics (20 min)
  - Team Overview & Philosophy
  - Contributor guide with focus on GitHub workflow
  - Overview of pacakges in safetyGraphics organization
  - Introduce safetyGraphics Vignettes 
  - safetyGraphics building blocks
     - data
     - charts
     - mapping
     - meta
2. Hello World (10 min)
   - Example - 5 min
   - Breakout - Play with safetyGraphicsInit (5 min)
3. Loading Custom Data (30 min)
   - Presentation Discuss `domainData` and `mapping` structure in more detail (5 min)
   - Examples (10 min)
   - Breakout - Excercise to load custom data (15 min) 
4. Break (10 min)
5. Chart/App Export (10 min) 
   - Example and Excercise together (no breakout) 
6. Creating Custom Charts (1 hr)
   - Presentation - `chart` object details,  relevant helper functions  & safetyCharts tour (15 min. maybe longer?)
   - Tweaking safetyCharts import - Example 1 & Excercise 1 together (5 min)
   - Example 2 - Hello World custom chart (5 min)
   - Presentation - Intro to Standard Eval (5 min)
   - Example 3/4 - Paneled demographics histogram (10 min)
   - Breakout - Convert static spaghetti plot for use in safetyGraphics (15 min)
   - Example 5 - Shiny App. (10 min)
7. Custom Domain (40 min)
   - Presentation - discuss `meta` (10 min)
   - Example 1 - conmeds (10 min)
   - Breakout - ecg/QT (20 min)
8. Chat/questions/discussion after workshop (zoom or use a different tool)


## NSE code stuff

Consider moving from: 
```
plot_aes <- aes_(
   x=as.name(settings$studyday_col), 
   y=as.name(settings$value_col), 
   group=as.name(settings$id_col)
)
```    

To: 
```
plot_aes <- aes(
   x=.data[[settings$studyday_col]] 
   y=.data[[settings$value_col]] 
   group=.data[[settings$id_col]]
)
```
