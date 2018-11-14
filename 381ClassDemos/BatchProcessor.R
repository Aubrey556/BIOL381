# Script for batch processing of multiple files
# Nov 1, 2018
# AMP

#################################################
# Function: FileBuilder
# creates a set of random files for regression
# input: fileN = number of files to create
# fileFolder= name of folder to hold files
# file size= c(min, max) number of rows
# fileNA = average number of NA values per column
#output: set of ramdom files
#______________________________________________
fileBuilder <- function(fileN=10,
                        fileFolder="RandomFiles/", #forward slash tells us that it's a folder
                        fileSize=c(15,100),
                        fileNA=3){
  for(i in seq_len(fileN)) {
    fileLength <- sample(fileSize[1]: fileSize[2], size=1) #grab a length between 15 and 100
    varX <- runif(fileLength)
    varY <- runif(fileLength)
    dF <- data.frame(varX, varY)
    badVals <- rpois(n=1, lambda=fileNA)
    dF[sample(nrow(dF), size=badVals),1] <- NA
    dF[sample(nrow(dF), size=badVals),2] <- NA
    
    # Need to create a lable for file name with padded zeros
    fileLabel <- paste(fileFolder,
                       "ranFile",
                       formatC(i, 
                               width=3,
                               format="d",
                               flag="0"),
                       ".csv", sep="")

    #set up data file and incorporate time stamp and minimal meta data
    
    write.table(cat("# Simulated random data file for patch processing","\n",
                    "# timestamp: ",as.character(Sys.time()), "\n",
                    "\n",
                    file=fileLabel,
                    row.names="",
                    col.names="",
                    sep=""))
    
    #finally, add the data frame
    write.table(x=dF,
                file=fileLabel,
                sep=",",
                row.names=FALSE,
                append=TRUE)
  }
}

#########################################
# function: regStats
#fits linear model and extracts statistics
# input: 2-column data frame with x and y
# ouput: slope, p-value, and r^2
#########################################
regStats <- function(d=NULL){
  if(is.null(d)){
    xVar <- runif(10)
    yVar <- runif(10)
    d <- data.frame(xVar,yVar)
  }
  . <- lm(data=d, d[,2]~d[,1])
  . <- summary(.)
  statsList <- list(Slope=.$coefficients[2,1],
                    pVal=.$coefficients[2,4],
                    r2=.$r.squared)
  return(statsList)
}

  
#########################################################
set.seed(100)

# _____________________________________________________
# Global variables
fileFolder <- "RandomFiles/"
nFiles <- 100
fileOut <- "StatsSummary.csv"
#___________________________________________________

# Create 100 random data sets
fileBuilder(fileN=nFiles)
fileNames <- list.files(path=fileFolder)

# create data frame to hold summary statistics
ID <- seq_along(fileNames)
slope <- rep(NA, nFiles)
pVal <- rep(NA, nFiles)
r2 <- rep(NA,nFiles)
statsOut <- data.frame(ID, fileNames, slope, pVal, r2)

# batch process through each file with a loop
for (i in seq_along(fileNames)){
  data <- read.table(file=paste(fileFolder,fileNames[i], sep=""), 
                     sep=",",
                     header=TRUE)
  dClean <- data[complete.cases(data),]
  
  . <- regStats(dClean)
  statsOut [i,3:5] <- unlist(.)
}

# set up output file and incorporate time stamp and minimal meatadata

write.table(cat("# Summary stats for ",
                "batch processing of regression models","\n",
                "timestamp:", as.character(Sys.time()),"\n",
                "AMP", "\n",
                "#_____________________________________________","\n",
                "\n",
                file=fileOut,
                row.names="",
                col.names="",
                sep=""))

# now add the data frame
write.table(x=statsOut,
            file=fileOut,
            row.names=FALSE,
            col.names=TRUE,
            sep=",",
            append=TRUE) #so we don't write over material we had before