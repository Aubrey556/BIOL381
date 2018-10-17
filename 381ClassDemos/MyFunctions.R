#Collection of Functions to a Source
#October 16 2018
#AMP



#######################
# FUNCTION: Get Data
# INPUTS: .csv data file
# OUTPUTS: data frame
#----------------------
getData <- function(){
  
  
  
  return("getData is working!")
}
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
summarizeOutput <- function(){
  
  
  
  return("summarizeOutput is working")
}
#----------------------
#######################
# FUNCTION: graphResults
# INPUTS:
# OUTPUTS:
#----------------------
graphResults <- function(){
  
  
  
  return("graphResults is working")
}
#----------------------