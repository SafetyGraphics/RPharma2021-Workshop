# RPharma2021-Workshop
Materials for the safetyGraphics R Phama 2021 Workshop

# Outline

1. Intro To safetyGraphics (20 min)
2. Hello World (10 min)
   - Breakout (5 min)
4. Basic Customization from Codebook (40 min)
   - Breakout (10 min)
6. Break (10 min)
7. Creating Custom Charts (1 hr 40 min)


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
