#Example of structured programming approach
#16 October 2018
#AMP
#-------------------------------------------
#Preliminaries
library(ggplot2)
source("MyFunctions.R")
#set.seed(100)
#-------------------------------------------
#Global variables
antFile <- "antcountydata.csv"
#ant data set
xCol <-7 # latitude center of each county
yCol <- 5 # number of ant species 
#-------------------------------------------


# Program body
temp1 <- getData(fileName=antFile) # construct the data frame

x <- temp1[,xCol] # extract the predictor variable
y <- temp1[,yCol] # extract the response variable

temp2 <- fitRegressionModel(xVar=x,yVar=y) # fit the model
temp3 <- summarizeOutput(temp2) # extract the residuals

graphResults(xVar=x, yVar=y) # create graph

print(temp3) # show the residuals
print(temp2) # show the model summary


