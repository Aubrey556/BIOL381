#Collection of Functions to a Source
#October 16 2018
#AMP



#######################
# FUNCTION: Get Data
# INPUTS: .csv data file
# OUTPUTS: data frame
#----------------------
getData <- function(fileName=NULL) {
  if(is.null(fileName)) {
    dataFrame <- data.frame(ID=101:110,
                            varA=runif(10),
                            varB=runif(10))
  }  else {
    dataFrame <- read.table(file=fileName,
                            header=TRUE,
                            sep=",",
                            stringsAsFactors=FALSE) 
  }
  return(dataFrame)
}
getData()
#----------------------
#######################
# FUNCTION: FitRegressionModel
# fits an ols regression model
# INPUTS: x and y vectors of numeric, must be same length
# OUTPUTS: entire summary from lm
#----------------------
fitRegressionModel <- function(xVar=runif(10), yVar=runif(10)){
dataframe <- data.frame(xVar, yVar)
regModel <- lm(yVar~xVar, data=dataFrame)
  
  return(summary(regModel))
}
fitRegressionModel()
#----------------------\#######################
# FUNCTION: summarizOutput
# INPUTS:
# OUTPUTS:
#----------------------
summarizeOutput <- function(z=NULL) {
  if(is.null(z)) {
    z <- summary(lm(runif(10)~runif(10)))
  }  
  return(z$residuals)
}
summarizeOutput()
#----------------------
#######################
# FUNCTION: graphResults
# INPUTS:
# OUTPUTS:
#----------------------
graphResults <- function(xVar=runif(10), yVar=runif(10)) {
  
  library(ggplot2)
  dataFrame <- data.frame(xVar,yVar)

  p1 <- qplot(data=dataFrame,x=xVar,y=yVar,geom=c("smooth","point"))
  print(p1)
  
}
graphResults()
str(graphResults())
#----------------------