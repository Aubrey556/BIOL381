# Simulation of randomization test for regression
# October 30, 2018
# AMP

library(ggplot2)
library(TeachingDemos)
#char2seed("Autumn Leaves")

# function: readData
readData <- function(z=NULL){
  if(is.null(z)){
    xObs <- 1:20
    yObs <- xObs +10*rnorm(20)
    dF <- data.frame(ID=seq_along(xObs),
                     xObs,
                     yObs)} else {
                       df <- read.table(file=z, row.names=1, header=TRUE, sep=",", stringsAsFactors=FALSE)} #else is what happens if there's something other than null for z
  return(dF)
}
readData()  

#Calculate the metric
getMetric <- function(z=NULL){
  if(is.null(z)){
    xObs <- 1:20
    yObs <- xObs +10*rnorm(20)
    z <- data.frame(ID=seq_along(xObs),xObs,yObs)}
  . <- lm(z[,3]~z[,2])
  . <- summary(.)
  . <- .$coefficients[2,1] #finding us metric(slope)
  slope <- .
  return(slope)
  }
getMetric()

#create randomization
shuffleData <- function(z=NULL){
  if(is.null(z)){
  xObs <- 1:20
  yObs <- xObs +10*rnorm(20)
  z <- data.frame(ID=seq_along(xObs),xObs,yObs)}
z[,3] <- sample(z[,3])
return(z)
}
shuffleData()

# calculate p-value from simulated metrics
getPVAL <- function(z=NULL){
  if(is.null(z)){
    z <- list(xObs=runif(1), xSim=runif(1000))}
  pLower <- mean(z[[2]] <= z[[1]])
  pUpper <- mean(z[[2]] >= z[[1]])
  return(c(pLower,pUpper))
}  
getPVAL()
z

#create histogram of simulated and observed metric
##################################################
# function: plotRanTest
# create ggplot of histogram of simulated values
# input: list of observed metric and vector of simulated metrics
# output: saved ggplot graph
#------------------------------------------------- 
plotRanTest <- function(z=NULL) {
  if(is.null(z)){
    z <- list(rnorm(1),rnorm(1000)) }
  dF <- data.frame(ID=seq_along(z[[2]]),simX=z[[2]])
  p1 <- ggplot(data=dF,mapping=aes(x=simX))
  p1 + geom_histogram(mapping=aes(fill=I("goldenrod"),color=I("black"))) +
    geom_vline(aes(xintercept=z[[1]],col="blue")) 
  
}
 
# now use functions to do the work
plotRanTest() 


###Now use functions to do the work
nSim <- 1000
Xsim <- rep(NA, nSim)
dF <- readData()        
Xobs <- getMetric(dF)

for(i in seq_len(nSim)){
  Xsim[i] <- getMetric(shuffleData(dF))
}

slopes <- list(Xobs, Xsim)

getPVAL(slopes)

plotRanTest(slopes)
