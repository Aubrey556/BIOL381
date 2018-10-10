# Examples of probability distributions
# October 2 2018
# AMP


#R prefixes:
#  d – probability density function
#p – cumulative distribution function
#q – quantile function (the “inverse” of p) = value of x that will yield a particular tail probability
#r – random number generation

#x is a random variable drawn from a stats distribution

library(ggplot2)
library(MASS)
# Poisson distribution
# Discrete X >= 0
# Random events occur with a constant rate lambda

MyVec <-dpois(x= seq(0,10), lambda = 1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)


MyVec <-dpois(x= seq(0,20), lambda = 6)
names(MyVec) <- seq(0,20)
barplot(height=MyVec)


MyVec <-dpois(x= seq(0,10), lambda = 0.2)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

#sum of area under curve is 1
sum(MyVec)
# with lambda= 2, what is the probability of obtaining a zero?
dpois(x=0, lambda=2)

#p function for cumulative distribution values 
hits <- 0:10
myVec <- ppois(q=hits, lambda=2)
qplot(x=hits, y=myVec, geom="col", color =I("black"), fill = I("goldenrod"))
#cumulative, so always increases, will build up to 1, then stay constant

# for a poisson with lambda=2, what is the probability of a single draw yielding X <=1?
ppois(q=1, lambda=2)
#Can do it a little differently too:
p1 <- dpois(x=0, lambda=2)
print(p1)
p2 <- dpois(x=1, lambda=2)
p2
p1+p2 #shows that ppois is cumulative and gets us the same thing as if we did them separately then added them together

#the q function is the inverse of the p function: What is the number of hits corresponding to a tail probability mass?
qpois(p=0.5, lambda=2.5) #2 or fewer hits will give us a 50% probability or 50% of our data
qplot(x=0:10, y=dpois(x=0:10, lambda=2.5), geom="col", color=I("black"), fill=I("goldenrod"))

# simulate values directly
ranPois <- rpois(n=1000, lambda=2.5)
qplot(x=ranPois, color=I("black"), fill=I("goldenrod"))# single continuous variable, so we only have to specify x

# for real or simulated data, get a 95% interval over the distribution

quantile(x=ranPois, probs = c(0.025, 0.975))

#binomial function, p = probability of dichotomous outcome
#number of trials
# x = possible outcomes, is bounded between 0 and number of trials that we conduct

hits <- 0:10
myVec <- dbinom(x=hits, size=10, prob=0.5)
qplot(x=0:10, y=myVec, geom= "col", color=I("black"), fill=I("goldenrod"))

# What is the probability of getting 5 heads out of 10 coin tosses?
dbinom(x=5, size=10, prob=0.5) #This is the prob. of getting exactly 5

hits <- 0:10
myVec <- dbinom(x=hits, size=10, prob=0.95) # if we're using an unfair coin
qplot(x=0:10, y=myVec, geom= "col", color=I("black"), fill=I("goldenrod")) 

pbinom(q=5, size=10, prob=0.5)
pbinom(q=4, size=9, prob=0.5)

#get an exact 95% confidence Interval
qbinom(p=c(0.025, 0.975), size=100, prob=0.7) #if true .7 coin, then the 95% CI is between 61 and 79

myCoins <- rbinom(n=50, size=100, prob=0.5)


#negative binomial - if we have a series of Bernouli trials (coin toss) with p=probability of success, how many failures until we reach that number of successes?
# a Poisson process in which the value of lambda is not constant

nbiRan <- rnbinom(n=1000, size=10, mu=5) #discreet values that on average have a number of 5
qplot(x=nbiRan, color=I("black"), fill=I("goldenrod")) 

# increase size( = less variable)
nbiRan <- rnbinom(n=1000, size=100, mu=5) #discreet values that on average have a number of 5
qplot(x=nbiRan, color=I("black"), fill=I("goldenrod")) 

#decreasing size parameter = more variable
nbiRan <- rnbinom(n=1000, size=0.1, mu=5) #size is small, so extremely rare events with really high numbers = skewed distribution, but still discrete integer values
qplot(x=nbiRan, color=I("black"), fill=I("goldenrod")) 


# continuous distribution
#uniform
#params = minimum and maximum

x <- runif(1000, min= 0, max=5) #bounded by 0 and 5
qplot(x=x, color=I("black"), fill=I("goldenrod")) 

#normal distribution
myNorm <- rnorm(n=100, mean=100, sd=2) #unbounded 
qplot(x=myNorm, color=I("black"), fill=I("goldenrod")) 

myNorm <- rnorm(n=100, mean=2, sd=2) #if we use a small mean, we can generate negative numbers in our normal distribution)
qplot(x=myNorm, color=I("black"), fill=I("goldenrod")) 
summary(myNorm)

tossZeroes <- myNorm[myNorm>0] #gets rid of zeros/negative numbers which is good, but now our mean is screwed up and too high
qplot(x=tossZeroes, color=I("black"), fill=I("goldenrod")) 
summary(tossZeroes)

# gamma, continuous positive values, not integers. Unbounded, but >0
# use shape and scale parameters (insead of mean and variance for ex.)

myGamma <- rgamma(n=100, shape=1, scale=10) #no negative values generated
qplot(x=myGamma, color=I("black"), fill=I("goldenrod")) 
#gamma with shape=1 is exponential with mean =scale parameter
#(size parameter in negative binomial is equivalent to shape parameter for a gammma distribution of lambdas)
#shape <=1 mode is very close to 0
myGamma <- rgamma(n=100, shape=0.1, scale=1) #no negative values generated
qplot(x=myGamma, color=I("black"), fill=I("goldenrod")) 

#mean=shape*scale
#variance = shape*scale^2

#beta distribution
#continuous, bounded at 0 and 1
#analagous to binomial, but it is the distribution of probability values, not the distribution of the number of successes  (ex. we know how many heads and tails we got, so we're trying to simulate the probability distribution it may have come from)
#shape1 = number of successes + 1
#shape2 = # of failures + 1

#shape1 = 1, shape2 = 1 (we haven't recorded any info yet, we have no heads and no tails)
myBeta <- rbeta(n=1000, shape1=1, shape2=1)
qplot(x=myBeta, color=I("black"), fill=I("goldenrod")) 

#shape1 = 2, shape2 = 1
myBeta <- rbeta(n=1000, shape1=2, shape2=1)
qplot(x=myBeta, color=I("black"), fill=I("goldenrod"))

# two tosses, 1 head and 1 tail
myBeta <- rbeta(n=1000, shape1=2, shape2=2)
qplot(x=myBeta, color=I("black"), fill=I("goldenrod"))

#throw two tails
myBeta <- rbeta(n=1000, shape1=1, shape2=3)
qplot(x=myBeta, color=I("black"), fill=I("goldenrod"))

# get better data (more coin tosses)
myBeta <- rbeta(n=1000, shape1=70, shape2=30)
qplot(x=myBeta, xlim=c(0,1), color=I("black"), fill=I("goldenrod"))

myBeta <- rbeta(n=1000, shape1=0.1, shape2=0.5) #doesn't work very well with shapes less than 1
qplot(x=myBeta, xlim=c(0,1), color=I("black"), fill=I("goldenrod"))
