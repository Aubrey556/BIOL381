### manipulating data using dplyr
### September 25, 2018
### AMP

###Start with a built in dataset
library(dplyr)
data(starwars)
class(starwars)

str(starwars)
glimpse(starwars) #better than str() in this case
head(starwars) #more informative

##clean up our data (baseR)
starwarsClean <- starwars[complete.cases(starwars[1:10]),]
head(starwarsClean)

#Check for NAs (base R)
is.na(starwarsClean[1,1])
anyNA(starwarsClean)
anyNA(starwars[1:10,])


##### filter(): pick/subset observations based on their values, works with rows
### uses > >= < <= != ==
### logical operators & | !

filter(starwarsClean, gender == "male", height < 180)
filter(starwarsClean, eye_color %in% c("blue", "brown"))
##excludes NAs (unless you ask for them), but other rows can include them 
filter(starwarsClean, gender =="male", height <180, height >100) # you can add multiple conditions

### arrange(): reorders rows
arrange(starwarsClean, height)
arrange(starwarsClean, desc(height))

#break ties by putting more column names
arrange(starwarsClean, height, desc(mass))
starwars1 <- arrange(starwars, height)
tail(starwars1)

### select(): Choose variables by their name, works with columns
glimpse(starwarsClean)
starwarsClean[1:10,] #base r subsetting
select(starwarsClean,1:10) # select in dplyr
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships))

#moving columns around using select
select(starwarsClean, name, gender, species, everything()) #reorders columns of your dataset to put name, gender, and species as the first 3
select(starwarsClean, contains("color"))
#other helper functions: ends_with, starts_with, matches(regular expressions), num_range


###rename columns with select
select(starwars, haircolor = hair_color) #new name comes first
rename(starwarsClean, haircolor = hair_color) #keeps all columns (better!)


#mutate(): create new varables with functions of existing variables
starwarsClean <-mutate(starwarsClean, ratio = height/mass) #arithmetic operators
head(starwarsClean$ratio)

glimpse(starwarsClean)
starwars_pounds <- mutate(starwarsClean, mass_lbs = mass* 2.2) #puts kg to pounds
head(starwars_pounds)

select(starwars_pounds, name:mass, mass_lbs, everything())
transmute(starwarsClean, mass_lbs = mass*2.2) #like mutate, but  you keep the new variable

###summarize() and group_by()
summarize(starwarsClean, meanHeight = mean(height))

#group_by for more usefulness          
starwarsGenders <- group_by(starwars, gender)
summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE), number = n()) #n() returns sample size

#### Summarize goups via pipe
starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height, na.rm = TRUE), TotalNumber = n())


