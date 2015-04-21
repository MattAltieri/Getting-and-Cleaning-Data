## Getting the data from the web

if(!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

## Look at a bit off the data

head(restData, n=3)

tail(restData, n=3)

## Make summary

summary(restData)

## more in depth information

str(restData)

## Quantiles of quantitative variables

quantile(restData$councilDistrict, na.rm=T)

quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))

## Make table

table(restData$zipCode, useNA="ifany") # By default, does not show you missing
                                       # vals

## Make 2 dimensional data

table(restData$councilDistrict, restData$zipCode)

## Check for missing values

sum(is.na(restData$councilDistrict)) # One option

any(is.na(restData$councilDistrict)) # Another

all(restData$zipCode > 0) # Tests basic assumptions, such as "are these all
                          # positive?"

## Row and column sums (to identify NAs for each col or row)

colSums(is.na(restData))

all(colSums(is.na(restData))==0)

## Values with specific characteristics

summary(restData$zipCode %in% c("21212")) # Makes a logical vector

summary(restData$zipCode %in% c("21212", "21213")) # Likewise

# Using that logical vector, you can subset rows
head(restData[restData$zipCode %in% c("212121", "21213"),])

## Crosstabs

data(UCBAdmissions)
DF <- as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF) # Syntax is Value ~ Row + Col
xt

## Flat tables

# Demonstrate pivoting on multiple fields (generates multiple tables as
# number of dimensions increase)
warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks ~ ., data=warpbreaks) # '.' means use all fields for pivot
xt

# Condens back into a single flat table
ftable(xt)

## Size of the object in memory

fakeData <- rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units="Mb")