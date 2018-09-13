# Basic properties of atomic vectors in R
# 13 September 2018
# AMP

# use assignment operator
x <- 5 #preferred
print(x)
typeof(x)
str(x) #structure of x
is.numeric(x) #asks if your variable is numeric
is.character(x)

#building one dimensional vectors
#the combine function
z <- c(3.2, 5, 5, 6)
str(z)

# c commmand always "flattens"

z <- c(c(3,4),c(5,6))
print(z)

# vectors of character strings
z <- c("perch", "bass", "red snapper", 'trout')
print(z)

#use single or double with embedded quotes
z <- c("This is 'one' strong", 'and another')
print(z)

# logical (True/False) variables

z <-c (TRUE, TRUE, FALSE)

# variable names
z <-3 #short, but not informative
plant_height <-3 #too long
plant.height <-3 # period used in other ways
plantHeight <-3 #camelCase naming

# properties of vectors
# 1) type
z <- c(1.1, 2, 3, 4)
typeof(z)
is.character(z)
is.integer(z)

# 2) length of an atomic vector
length(z)
length(y)

# 3) names
z <- runif(5) #random uniform values between zero and 1
#names not initially assigned
names(z)
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita") #assigns names
print(z)


# or add names when variable is created

z2 <- c(gold=3.3, silver=10, lead=2)
print(z2)
names(z2) <- NULL
print(z2)
names(z2)  <- c("red", "green")
print(z2)
# names do not have to be distinct
names(z2) <- c("red", "red")
print(z2)

# special data types
# NA values for missing data
z <- c(3.2, 3.2, NA)
typeof(z)
typeof(z[3])
z1 <- NA
typeof(z1)


# NA values carry through for entire vector
is.na(z) #is there a missing value for any of the z numbers?
!is.na(z) #flips TRUE FALSE output. i.e. Which ones are not NA?
mean(z) #since value is missing, cannot make calculation
mean(!is.na(z))

# NaN - Inf and Inf from numeric division (Not a number, infinity)
z <- 0/0
typeof(z)
print(z)
z <- 1/0
print(z)
z <- -1/0
print(z)

# three features of atomic variables
# 1) coercion
a <- c(2, 2.0)
typeof(a)
b <- c("purple", "green")
d <- c(a,b)
typeof(d)
print(d)
# coercion order:
#logical -> integers -> doubles -> character

# Conversions very useful in combination with logical variables
a <- runif(10)
print(a)
a > 0.5
aboolean <- a > 0.5 # vector of logicals
sum(a)
sum(aboolean)# gets turned into logicals, trues get turned into 1, false ->0, so I had two times when a>.5
sum(a > 0.5) #combines into one function: adding and coercing a logical
mean(a > 0.5) #gives proportion of TRUES

#tail values for a normal distribution
mean(rnorm(1000)==2) #rnorm is random normal variable, mean 0, SD of 1, determine if greater than 2, then take the mean to find proportion greater than 2. Double == sign, how many things are exactly equal to 2?
mean(rnorm(1000)!=2) #how many values don't equal 2?

# Vectorization
z <- c(10, 20, 30)
z + 1     
y <- c(1,2,3)
z + y
 z^2
myResult <- z^2 

#recycling
z <- c(10, 20, 30)
y <- c(1,2)
z+y #R starts recycling the shorter variable as needed

# Creation of vectors
# creating an empty vector and exapnding it (don't do this! It is super slow)

z <- vector(mode="numeric", length = 0)
print(z)
z <- c(z,5)
print (z)
