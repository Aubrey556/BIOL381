#functions in R
#October 11 2018
#AMP

sum(3,2) # 'prefix' functions
3 + 2 # an operator, but actually an 'infix' function, not a prefix, comes "inbetween" the two characters
`+`(3,2)
`<-`(yy,3) #assigns 3 to yy
yy


sd # prints function contents/underlying code
sum #primitice functions, can't see as easily b/c it's been hardcoded in b/c it's used so often so will run faster
sd(c(3,2))
#sd() # uses default parameters
sum()


#######################
# FUNCTION: HardyWeinberg
# INPUTS: an allele frequency p(0,1)
# OUTPUTS: pa nd the frequencies of the 3 genotypes AA, AB, and BB
#----------------------
HardyWeinberg <- function(p=runif(1)) { #give it a random default value for p between 0 and 1
  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,  #controls number of digits in output
                     AA=fAA,
                     AB=fAB,
                     BB=fBB), digits=3)
return(vecOut)
}
#----------------------
HardyWeinberg
HardyWeinberg(p=0.02)
HardyWeinberg()

#Multiple return statements for different possible return values
#######################
# FUNCTION: HardyWeinberg2
# INPUTS: an allele frequency p(0,1)
# OUTPUTS: pa nd the frequencies of the 3 genotypes AA, AB, and BB
#----------------------
HardyWeinberg2 <- function(p=runif(1)) { #give it a random default value for p between 0 and 1
  if(p>1.0| p<0.0) { #if this, OR this
    return("Function failure: p out of bounds")}
  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,  #controls number of digits in output
                     AA=fAA,
                     AB=fAB,
                     BB=fBB), digits=3)
  return(vecOut)
}
#----------------------
HardyWeinberg2(p=0.5)
z <- HardyWeinberg2(p=1.1)
z

#######################
# FUNCTION: HardyWeinberg3
# INPUTS: an allele frequency p(0,1)
# OUTPUTS: pa nd the frequencies of the 3 genotypes AA, AB, and BB
#----------------------
HardyWeinberg3 <- function(p=runif(1)) { #give it a random default value for p between 0 and 1
  if(p>1.0| p<0.0) { #if this, OR this
    stop("Function failure: p out of bounds")}
  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,  #controls number of digits in output
                     AA=fAA,
                     AB=fAB,
                     BB=fBB), digits=3)
  return(vecOut)
}
#----------------------
HardyWeinberg3()
#HardyWeinberg3(p=1.1)

# scoping in functions
# global variables
# local variables

myFunc <- function(a=3, b=4){
  z <- a + b
  return (z)
}
myFunc()

myFuncBad <- function(a=3){
  z <- a + b
  return(z)
}
myFuncBad()
b <- 100 #creates a global variable that is present throughout the code, so if we try and run our code with the default values, it will use the 100 that is lying around a variable outside the system. We want to define things as an input parameter so that this doesn't happen. We don't want outside changes to affect the way our function works
myFuncBad()




#######################
# FUNCTION: fitlinear
# INPUTS: numeric vector of predictor (x) and response (y)
# OUTPUTS: slope and p value
#----------------------
fitlinear <- function(x=runif(20),y=runif(20)) {
  
  myMod <- lm(y~x) # fit of linear model
  myOut <- c(slope=summary(myMod)$coefficients[2,1],
            pValue=summary(myMod)$coefficients[2,4])
  plot(x=x, y=y)
  return(myOut)
}
#----------------------
fitlinear()
varA <- 1:100
varB <- rnorm(100)

fitlinear(x=varA, y=varB)

