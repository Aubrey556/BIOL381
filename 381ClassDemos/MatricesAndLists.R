# basic operations on matrices and lists
# 18 September 2018
# AMP

m <- matrix(data=1:12, nrow=4, ncol=3)


print(m)
dim(m) #dimensions: Number of rows, then # of columns
m <- matrix(data = 1:12, nrow=4, byrow=TRUE) #specifies how we will fill that vector, says we'll fill so numbers fill across the row instead of down the column


print(m)
#change dimensions
dim(m) <- c(6,2)
print(m)
dim(m) <- c(4,3)
print(m)
nrow(m)
ncol(m)
length(m) #looks at number of elements in vector, there are 4x3, so 12

#add row and column names
rownames(m)
rownames(m) <- c("a", "b", "c", "d")
print(m)
colnames(m) <- LETTERS[1:ncol(m)]
print(m)
print(m[2,3]) #prints value in second row, 3rd column
print(m[1:2,2:3])
print(m[,2:3]) #will print all rows if not specified, and only 2nd and 3rd columns
print(m[1:2,])
print(m[,])
rownames(m) <- paste("Species",LETTERS[1:nrow(m)],sep="")
colnames(m) <- paste("Site", 1:ncol(m),sep="")
print(m)
m["SpeciesD","Site2"]


dimnames(m) <- list(paste("Site", 1:nrow(m),sep=""),
                    paste("Species",letters[1:ncol(m)], sep=""))

#t for transpose
print(t(m))

# adding rows or columns to matrix
m2 <- t(m)
m2 <- rbind(m2, c(10,20,30,40)) #bind a row to your matrix
print(m2)
rownames(m2)
rownames(m2)[4] <- "myFix"
print(m2)
m2["myFix", "Site1"]
m2[c("Speciesc","myFix"), c("Site1", "Site4")]




#Introducing LIsts

myList <- list(1:10, matrix(1:8, nrow=4, byrow=TRUE), letters[1:3], pi)
myList[4]
myList[4] - 3 #have to pull item out first, can't do it from a list
myList[[4]] -3 #pulls out the value




# list of 10 elements, a train with 10 cars
# x[5] fifth car in the train
#x[[5]] contents of the 5th car in the train
#x[c(4,5,6)] a new train with 3 cars

myList[[2]] #full matrix
myList [[2]][[3,2]] #first pull matrix, then give me element in row 3, column 2

#naming list items

myList2 <- list(Tester=FALSE, littleM=matrix(1:9, nrow=3))
myList2$littleM #prints entire matrix
myList2$littleM[1,] #pulls first row out of littleM


#unlist is very helpful for lists!
unRolled <- unlist(myList2)
unRolled

#use unlist for accessing model output
library(ggplot2)
yVar <- runif(10)
xVar <- runif(10)
myModel <- lm(yVar~xVar) #statistical function - want to fit a linear model
qplot(x=xVar, y=yVar)
print(myModel)
print(summary(myModel))
str(summary(myModel))
summary(myModel)$coefficients
summary(myModel)$coefficients[2,4] #p-value

#find what you want by unlisting the model summary

u <- unlist(summary(myModel))
u 
mySlope <- u$coefficients2
myPValue <- u$coefficients8

mySlope
myPValue

# Data frame
# - a list of atomic vectors
# - all vectors(=columns) are the same length

# build a data frame from scratch

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"),each=4)
varC <- runif(12)
dFrame <- (data.frame(varA, varB, varC, stringsAsFactors=FALSE))
str(dFrame)
head(dFrame)

# add a row with rbind

newData <- list(varA=13, varB = "HighN", varC = 0.668)
print(newData)
str(newData)
dFrame <- rbind(dFrame,newData)
tail(dFrame)

# add a column to a data frame
 newVar <- runif(13)
dFrame <- cbind(dFrame, newVar) 
head(dFrame)

#similarities and differences of data frames and matrices

#build a data frame and a matrix with same structure
zMat <-matrix(data=1:30,ncol=3,byrow=TRUE)
zDframe <- as.data.frame(zMat)

str(zMat)
str(zDframe)

head(zDframe)
head(zMat)

zMat[3,3] #pulls out 3rd row, third column
zDframe[3,3]

#column referencing 
zMat[,2]
zDframe[,2]
zDframe$V2 #dollar signs are ONLY for names items in LISTS

#referencing single items
zMat[2] #remember R looks at a matrix down columns first
zDframe[2] #this looks at the second variable in the set (the second column)
zDframe["V2"]
zDframe$V2


#subscripting and dealing with missing data

set.seed(99)
z <- 1:10 # simple sequence
z
z <- sample(z) #remember, samples without replacement, will shuffle things
z
z < 4 #logical vector
z[z<4] #subset
which(z <4) #get subscripts (tells us which positions our numbers that are less than 4 are in)
z[which(z<4)] # what numbers are in the slots where z<4?

zD <- c(z,NA,NA)
zD

zD[zD < 4] #works, but NA gets carried along too
zD[which (zD<4)]

# use complete.cases to eliminate NA values
##complete cases works row by row to eliminate data

print(zD)
complete.cases(zD)
zD[complete.cases(zD)] #give me all zD with complete cases

#use this to find missing value slots

which(!complete.cases(zD)) #finds values which are not complete, then tells us the slots they're in

#now apply this to a matrix
m <- matrix(1:20, nrow=5)
m[1,1] <- NA
m[5,4] <- NA #just add some NAs in the matrix 
m

m[complete.cases(m),] #do this to each row, keeps columns intact
#stripped out the first and last row
m[complete.cases(m[,c(1,2)]),] #will only get rid of NAs for columns 1 and 2


