# Additional details on for loops
# October 25, 2018
# AMP

library(tcltk2)
library(ggplot2)

####################################
#FUNCTION RanWalk
# Stochastic random walk
# input: times=number of time steps
#        n1 <- initial popultion size
#        lambda <- finite rate of increase
#        noiseSD standard deviation of rnorm with average of 0
# output: vector n with population sizes > 0 until extinction, then NA
####################################

library(ggplot2)
library(tcltk2)
RanWalk <- function(times=100,
                    n1 = 50,
                    lambda = 1.0,
                    noiseSD = 10) {
  n <- rep(NA, times)
  n[1] <- n1 # initalize first population size
  noise <- rnorm(n=times, mean=0, sd=noiseSD)
  for(i in 1:(times-1)){
    n[i+1] <- lambda*n[i] + noise[i]
    if(n[i+1] <=0) {
      n[i+1] <-NA
      cat("Population extinction at time", i-1, "\n")
#      tkbell() #rings the bell on our computer, tells us the population has gone extinct
      break}#exits the looping structure
  }
  return(n)
}
myWalk <- RanWalk(noiseSD=10)
qplot(x=1:100, y=myWalk, geom="line")
#qplot(x=1:100, y=RanWalk(), geom="line")

# using double for loops
m<- matrix(round(runif(20), digits=2), nrow=5)
# loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}
print(m)            

# loop over columns
m <- matrix(round(runif(20), digits=2), nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# double for loop for operating on each element
m <- matrix(round(runif(20), digits=2), nrow=5)
for (i in 1:nrow(m)) {
  for(j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i +j
  } # close j loop (for columns)
} # close i loop (rows)
print(m)

# writing functions for equations and sweeping over parameters
#S=cA^z power function for a species-area relationship,A=area of island, S=#spp, c,z=constants


#########################################
#function: SpeciesAreaCurve
# creates power function for A and S
# inputs A = vector of island areas
# c is the intercept constant
# z is the slope constant
# output: a vector of species richness
SpeciesAreaCurve <- function(A=1:5000, 
                             c=0.5,
                             z=0.26){
  S <- c*(A^z)
  return(S)
}

SpeciesAreaCurve()
head(SpeciesAreaCurve())

##############################################
# function: SpeciesAreaPlot
#input: A= vector of areas
#c and z are constants
# output: smoothed curve with parameter S shown in graph
SpeciesAreaPlot <- function(A=1:5000,
                            c=0.5,
                            z=0.26){
  plot(x=A,
       y=SpeciesAreaCurve(A,c,z), 
       type="l",
       xlab= "Island Area",
       ylab= "S",
       ylim=c(0,2500))
  mtext(paste("c =", c, "z =", z), cex=0.7)
}
SpeciesAreaPlot()   

# global variables
cPars <- c(100, 150, 175)
zPars <- c(0.10, 0.16, 0.26, 0.3)
par(mfrow=c(3,4))

for(i in seq_along(cPars)) {
  for(j in seq_along(zPars)) {
    SpeciesAreaPlot(c=cPars[i], z=zPars[j])
  }
}

#expand grid for setting up a data frame with different parameter combinations
cPars
zPars
expand.grid(cPars,zPars)

###############################################
# function: SA_Output
SA_Output <- function(S=runif(10)) {
  sumStats <- list (SGain=max(S)-min(S),
                    SCV <- sd(S)/mean(S))
  return(sumStats)
}
SA_Output()                    

# Build program body with a single loop through parameters in model frame

# Global Variables
Area <- 1:5000
cPars <- c(100, 150, 175)
zPars <- c(0.10, 0.16, 0.26, 0.30)

# set up model data frame
modelFrame <- expand.grid(c=cPars, z=zPars)
modelFrame$Gain <- NA
modelFrame$SCV <- NA
head(modelFrame)


# cycle through parameter combinations
for (i in 1:nrow(modelFrame)){
  
  #generate the S vector
  temp1 <- SpeciesAreaCurve(A=Area,
                            c=modelFrame[i,1],
                            z=modelFrame[i,2])

  #calculate output statistics
  temp2 <- SA_Output(temp1)

  # pass results to columns in modelFrame
  modelFrame[i,c(3,4)] <- temp2
}
print(modelFrame)

library(ggplot2)
Area <- 1:5
cPars <- c(100, 150, 175)
zPars <- c(0.10, 0.16, 0.26, 0.30)

modelFrame <- expand.grid(c=cPars, z=zPars, A=Area)
modelFrame$S <- NA
modelFrame

# now loop through parameters and fill with SA

for(i in 1:length(cPars)) {
  for(j in 1:length(zPars)) {
    modelFrame[modelFrame$c==cPars[i] & modelFrame$z==zPars[j], "S"] <- SpeciesAreaCurve(A=Area, c=cPars[i], z=zPars[j])
  } # close j loop
} # close i loop
head(modelFrame)

# graph facets with the long format

p1 <- ggplot(data=modelFrame)
p1 + geom_line(mapping=aes(x=A,y=S)) +
  facet_grid(c~z)
p2 <- p1
p2+geom_line(mapping=aes(x=A, y=S, group=z)) +
  facet_grid(.~c)
p3 <- p1
p3 + geom_line(mapping=aes(x=A, y=S, group=c))+
  facet_grid(z~.) #rows followed by columns. Period collapses the columns. So in the graph, we only have one column of data, but we have different panels for the rows. Can do this because we have grouped c already
