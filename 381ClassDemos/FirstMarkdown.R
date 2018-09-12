## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- eval=FALSE, echo=TRUE----------------------------------------------
## #Comments are important!
## pred <- seq(1,10) # make a vector of integers from 1 to 10
## response <- runif(10)
## print(response)
## 
## # now plot a graph
## plot(x=pred, y=response, type="b")
## 

## ---- echo=TRUE, results='asis'------------------------------------------
library(knitr)
kable(head(iris))

