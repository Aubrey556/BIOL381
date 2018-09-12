#Explain what the heck this script is. What is it doing, what project is it associated with? Give as many details as possible so that you will understand later on what this is from!

#6 September 2018
#AMP
#--------------------------------------------------------------------------
#Preliminaries
library(ggplot2)
# set.seed(100) #We will get identical values for everything we calculate, even if we use the random number generator - there is a set of numbers (pseudo-random), but if we all type in 100, we will all get the same numbers. If I typed in 101, I would get a completely different set of numbers.
library(TeachingDemos)
# char2seed(x="green tea") #can now use any phrase or text in that you want to set your seed, don't need to use a number like 100 or 101. It converts the text into a number to use as your seed.

#Global variables
nRep <- 10 #number of values

#Create or read in data
ranVar1 <- rnorm(n=nRep) #invokes random number generator with SD 1 and mean=0 (default values), but can specify and change those explicitly as you want
# print(ranVar1)

#Peek at Data
# head(ranVar1) #first 6 elements of your set/vector
# tail(ranVar1) #last 6 elements of your set/vector
# length(ranVar1)
# str(ranVar1) #What is the structure of our variable?

#Create second variable
ranVar2 <- rnorm(n=nRep)

#visualize data
qplot(x=ranVar2)
qplot(x=ranVar2,
      color=I("black"),
      fill=I("goldenrod"))


