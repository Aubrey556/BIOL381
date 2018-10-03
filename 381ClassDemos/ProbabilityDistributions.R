# Examples of probability distributions
# October 2 2018
# AMP

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





#R prefixes:
#  d – probability density function
#p – cumulative distribution function
#q – quantile function (the “inverse” of p) = value of x that will yield a particular tail probability
#r – random number generation

#x is a random variable drawn from a stats distribution

