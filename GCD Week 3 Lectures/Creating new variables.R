## Getting the data from the web

if(!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

## Creating sequences

# Index the first 10 records, stepping by 2s (odd #s)
s1 <- seq(1, 10, by=2)
s1

# Index 3 records between the start and end points, evenly distributed
s2 <- seq(1, 10, length=3)
s2

# Create and index the same length as a vector (good for looping)
x <- c(1, 3, 8, 25, 100)
seq(along=x)

## Subsetting variables & adding a logical variable for that subset

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
summary(restData$nearMe)

## Creating binary variables

restData$zipWrong <- ifelse(restData$zipCode < 0, T, F)
summary(restData$zipWrong)
summary(restData$zipCode < 0)
table(restData$zipWrong, restData$zipCode < 0)

## Creating categorical (quantitative) variables

restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
summary(restData$zipGroups)

table(restData$zipGroups, restData$zipCode)

## Easier cutting

library(Hmisc) # has cut2
restData$zipGroups <- cut2(restData$zipCode, g=4) # g is nbr of quantile grps
summary(restData$zipGroups)

## Creating factor variables

# Zip code is integer but not quantitative
# Make it a factor!
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

class(restData$zcf)

## Levels of factor variables

yesno <- sample(c("yes", "no"), size=10, replace=T)
yesnofac <- factor(yesno) # By default, is alphabetical (no=1, yes=2)
yesnofac
as.numeric(yesnofac)

yesnofac <- factor(yesno, levels=c("yes", "no")) # To override default sorting
yesnofac
as.numeric(yesnofac) # Now no=2, yes=1

yesnofac <- relevel(yesnofac, ref="yes") # Another way, but can only spec lvl 1
yesnofac
as.numeric(yesnofac)

## Cutting produces factor variables!

library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
class(restData$zipGroups)

## Using the mutate function to create and add in a single function

library(Hmisc)
library(plyr)
restData2 <- mutate(restData, zipGroups=cut2(zipCode, g=4))
summary(restData2$zipGroups)