# For loops in R
# October 23, 2018
# AMP

#start with for(var in seq) variable, followed by in, followed by 2nd varaible which is a sequence. Next need a { so we can have more than 1 line of code associated with the for loop.
#for(var in seq){ #start of loop
    #body of loop

#} # end of loop
#var= index variable (i, j, or k are good to use, or use m for a matrix, or v for a vector. Don't use t for time, since it transposes a matrix/is a function in R. Same for c, don't use.)

myDogs <- c("chow", "akita", "malamute", "husky", "samoyed")

# Not recommended for looping
for(i in myDogs) {
  print(i)
}

#better to create a sequence vector

for (i in 1:length(myDogs)) {
  cat("i =", i, "myDogs[i] =", myDogs[i], "\n")
}

myBadDogs <- NULL
for (i in 1:length(myBadDogs)) {
  cat("i =", i, "myBadDogs[i] =", myBadDogs[i], "\n")
}

# use seq_along
myBadDogs <- NULL
for (i in seq_along(myBadDogs)) {
  cat("i =", i, "myBadDogs[i] =", myBadDogs[i], "\n")
}

#use external variable for vector length
zz <-5
for( i in 1:zz) {
  cat("i =", i, "myDogs[i] =", myDogs[i], "\n")
}
  
#tip #1 don't do unnecessary things in the for loop! Better to make the uppercase command first outside of the loop so it doesn't slow it down.
for (i in 1:length(myDogs)) {
  myDogs[i] <- toupper(myDogs[i])
  cat("i =", i, "myDogs[i] =", myDogs[i], "\n")
}

myDogs <- c("chow", "akita", "malamute", "husky", "samoyed")
myDogs <- toupper(myDogs)
for (i in 1:length(myDogs)) {
  cat("i =", i, "myDogs[i] =", myDogs[i], "\n")
} # we get the same output

#Tip #2: do not change object dimensions in a loop (c, list, rbind, cbind)

myDat <- (runif(1))
for (i in 2:20) {
  temp <- runif(1)
  myDat <- c(myDat, temp)
  cat("loop number=", i, "vector element =", myDat[i], "\n")
}  
head(myDat)

#Tip #3: Do not write a loop if you can vectorize the operation.
myDat <- 1:10
for(i in seq_along(myDat)) {
  myDat[i] <- myDat[i] + myDat[i]^2
  cat("loop number =", i, "vector element - ", myDat[i], "\n")
}

z <- 1:10
z <- z+z^2
z
#Tip #4: Be alert to distinction between counter variable i and the vector element z[i]

z <- c(10,2,4)
for(i in seq_along(z)) {
  cat("i=", i, "z[i] = ", z[i], "\n")
}

#Tip #5: Use 'next' function to skip certain elements in the loop

z <- 1:20
# what if we want to work with only the odd numbered elements?

for (i in seq_along(z)){
  if(i %% 2==0) next#double %% is a remainder function after division. Is the remainder after we divide by 2 equal to zero?
  print(i)
}

# alternative that may be faster
z <- 1:20
zsub <- z[z %% 2!=0] # keep the odd elements
length(zsub)
for(i in seq_along(zsub)) {
  cat("i=", i, "zsub[i] =", zsub[i], "\n")
}  

