## Start with reshaping

library(reshape2)
head(mtcars)

## Melting data frames

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"),
                measure.vars=c("mpg", "hp"))
head(carMelt, n=3)

tail(carMelt, n=3)

## Casting data frames

cylData <- dcast(carMelt, cyl ~ variable) # Syntax: rows ~ columns
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean) # Syntax: rows ~ cols, func
cylData

## Averaging values

head(InsectSprays)

tapply(InsectSprays$count, InsectSprays$spray, sum) #Syntax: measure, dim, func

## Split-Apply-Combine

# Option 1
spIns <- split(InsectSprays$count, InsectSprays$spray)
sprCount <- lapply(spIns, sum)
unlist(sprCount)

# Option 2
spIns <- split(InsectSprays$count, InsectSprays$spray)
sapply(spIns, sum)

## Another way -- plyr package

library(plyr)
ddply(InsectSprays, .(spray), summarize, sum=sum(count))

## Creating a windowed sum

library(plyr)
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))
dim(spraySums)

head(spraySums)