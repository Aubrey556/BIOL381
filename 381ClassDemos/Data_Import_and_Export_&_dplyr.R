#### Data import/export and dplyr
####Septermber 27, 2018
####AMP


### installing packages
## only have to do this once, usually just do it in the console, b/c it only needs to be done once
# install.packages("")

### projects - super useful for organization

### R vs R Markdown - R Markdown needs chunks in it
##Remember to run everything first that needs to be - i.e. you can't print out what y is if you haven't run the line that assigns it

###Exporting and Importing Data

#### write.table(): useful for when you want to work outside of R or with a csv file
library(dplyr)
data(starwars)

starwars1 <- select(starwars, name:species)
glimpse(starwars1)
write.table(starwars1, file="StarwarsInfo.csv", row.names=FALSE, sep = ",") #creating a csv
### option: write.csv()

#### read.table(): useful when you have metadata
data <- read.table(file="FileName.csv", row.names = FALSE, header=TRUE, sep= ",", stringsAsFactors = FALSE) ###general format

starwarsData <- read.table("StarwarsInfo.csv", header = TRUE, sep= ',', stringsAsFactors = FALSE)
head(starwarsData)
class(starwarsData)
data <- as_tibble(starwarsData)
class(data)
glimpse(starwarsData)

###saveRDS(): Useful when working only in R; saves a single R object as a file
saveRDS(starwars1, file = "StarwarsTibble")
###readRDS(): restores R object
sw <- readRDS("StarwarsTibble")
class(sw)

#### Further into dplyr
### Counts
glimpse(sw)


### count our NAs (not in dplpyr)
sum(is.na(sw))
### count our nonmissing data
sum(!is.na(sw))

swSp <- sw %>%
  group_by(species) %>%
  arrange(desc(mass))
swSp

swSp %>%
  summarize(avgMass = mean(mass,na.rm=TRUE), avgHeight = mean(height, na.rm = TRUE), n=n()) ## n() gives count info (sample size))

### filter out low sample size
swSp %>%
  summarize(avgMass = mean(mass,na.rm=TRUE), avgHeight = mean(height, na.rm = TRUE), n=n()) %>%
  filter(n>= 2) %>%
  arrange(desc(n))

### using the count helper
swSp %>%
  count(eye_color)

swSp %>%
  count(wt = height) # gives the sum using "weight" (wt)

#### Useful summary functions
starwarsSummary <- swSp %>%
  summarize(avgHeight = mean(height, na.rm = TRUE), 
            medHeight = median(height, na.rm = TRUE), 
            sdHeight = sd(height, na.rm = TRUE), 
            IQRHeight = IQR(height, na.rm = TRUE), 
            min_height = min(height, na.rm = TRUE), 
            first_height = first(height), 
            nth = nth(height, 4), 
            n_eyecolors = n_distinct(eye_color), 
            n=n()) %>%
  filter(n>=2) %>%
  arrange(desc(n))

starwarsSummary

### group_by() use multiple variables/ungroup
sw2 <- sw[complete.cases(sw),] # only incluse rows that don't have NAs
glimpse(sw2)

sw2groups <- group_by(sw2, species, hair_color)
summarize(sw2groups, n=n())

sw3groups <- group_by(sw2, species, hair_color, gender)
summarize(sw3groups, n=n())

# ungroup
sw3groups %>%
  ungroup() %>%
  summarize(n=n())

## Grouping with mutate()
### Ex. standardize within groups
sw3 <- sw2 %>%
  group_by(species) %>%
  mutate(prop_height = height/sum(height)) %>%
  select(species, height, prop_height)
sw3

sw3 %>%
  arrange(species) # alphabetical order

library(dplyr)
dplyr::case_when() ##for using specific functions that might be in two libraries, or masked in this library

