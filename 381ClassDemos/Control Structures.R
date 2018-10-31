#Control structures for non-linear execution of code
#October 18, 2018
#AMP

#simple inequalities
5 > 3
5<3
5<=5
5==3 #equals, need the double otherwise, tries to assign the value 3 to 5, which we can't do
5!=3 #! means not, so this means 5 doesn't equal 3, so should return a TRUE

# use & for AND

5 > 3 & 1 != 2 #if we return a value of True, this means BOTH statements are true
1==2 & 1!=2 # generates a FALSE because at least ONE of them is false

# | for OR
1==2 | 1!=2 #generates a TRUE, because at least one of them is true

# this works with vectors
1:5 > 3

a <- 1:10
b <- 10:1
a > 4
b > 4
a > 4 & b > 4

# use "long form" of & and | to evaluate only the first element

a > 4 && b > 4 #just evaluates the FIRST encounter in each vector

# also || for long form of OR

a < 4 | b > 4
a < 4 || b > 4
a[1] < 4 | b[1] > 4 # identical statement to the previous statement

# xor for exclusive OR testing
# work for (TRUE FALSE) but not (TRUE TRUE) #must be one true and one false to generate a TRUE for this statement
a <- c(0,0,1)
b <- c(0,1,1)
a|b
xor(a,b)

# set operators

#boolean algebra on sets of atomic vectors (logical, numeric, character strings)

"three" < "five" #r alphabetizes the character strings, so f<t not t<f
FALSE < TRUE #when we convert to integers, FALSE is a zero, TRUE is a 1

a <- 1:7
b <- 5:10

# union to get all elements
union(a,b) #returns all different elements from both vectors, but doesn't repeat any elements

#intersect to find common elements
intersect(a,b) #only finds things that are in both vectors

#setdiff to get distinct elements in a
setdiff(a,b) #what elements are only present in a?
setdiff(b,a) #what elements are only present in b?

# setequal to check for identical elements
setequal(a,b) #returns FALSE, because these vectors are not identical

# equality compares element by element
z <- matrix(1:12, nrow=4, byrow=TRUE)
print(z)
z1 <- matrix(1:12,nrow=4,byrow=FALSE)
print(z1)
z==z1

# use identical for entire structures
identical(z,z1)
z1 <- z
identical (z,z1)

# use %in% function to check for a subset

d <- 12
d %in% union(a,b) #no, 12 is not within the union of a and b sets
is.element(d,union(a,b)) #does the same thing, but is a little less readable

d <- c(10,12)
d %in% union(a,b) #returns true, false because evaluates each element at a time
d %in% a

# conditional if statements
z <- signif(runif(1),digits=2)
print(z)
z > 0.5
# "naked" if statement
if (z > 0.5) cat(z, "is a bigger than average number", "\n")

# if with else
if (z > 0.8) cat(z, "is a large number", "\n") else if(z <0.2) cat(z, "is a small number", "\n") else {cat(z, "is a number of typical size", "\n")
    cat("z^2 =", z^2, "\n")}

# be careful with if statements, which require a single logical value
z <- 1:10

# this doesn't do anything, the if only looks at the first element of the vector
if(z > 7) print(z)

#also not so good
if (z < 7) print (z)

# use subsetting!
print(z[z<7])

# ifelse to fill vectors

# distribution of eggs laid lambda=10.2, p(parasitism)=35%

tester <- runif(1000) # start with random uniform elements
eggs <-ifelse(tester >0.35, rpois(n=1000,lambda=10.2),0)
hist(eggs)

pVals <- rbeta(n=1000, shape1 <- 0.5, shape2 <- 0.5)
z <- ifelse(pVals<= 0.025, "lowerTail", "nonSig")
z[pVals>=0.975] <-"upperTail"
head(z)
table(z) #gives counts in different categories

#alternative coding
z1 <- rep("nonSig", 1000)
z1[pVals<=0.025] <- "lowerTail"
z1[pVals>=0.975] <- "upperTail"
library(ggplot2)
qplot(x=pVals, fill=z1) #doesn't need a data frame, can use individual vectors
