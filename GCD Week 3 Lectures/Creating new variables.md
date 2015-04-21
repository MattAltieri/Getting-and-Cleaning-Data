## Why create new variables?
- Often the raw data won't have a value you are looking for
- You will need to transform the data to get the values you would like
- Usually you will add those values to the data frames you are working with
- Common variables to create
	- Missingness indicators
	- "Cutting up" quantitative variables
	- Applying transforms

## Example data set

![](restaurants.png)

#### [https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g](https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g)

## Getting the data from the web

``` r
if(!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")
```

## Creating sequences

``` r
# Index the first 10 records, stepping by 2s (odd #s)
s1 <- seq(1, 10, by=2)
s1
```
``` r
[1] 1 3 5 7 9
```
``` r
# Index 3 records between the start and end points, evenly distributed
s2 <- seq(1, 10, length=3)
s2
```
``` r
[1]  1.0  5.5 10.0
```
``` r
# Create and index the same length as a vector (good for looping)
x <- c(1, 3, 8, 25, 100)
seq(along=x)
```
``` r
[1] 1 2 3 4 5
```

## Subsetting variables & adding a logical variable for that subset

``` r
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
summary(restData$nearMe)
```
``` r
   Mode   FALSE    TRUE    NA's 
logical    1314      13       0 
```

## Creating binary variables

``` r
restData$zipWrong <- ifelse(restData$zipCode < 0, T, F)
summary(restData$zipWrong)
```
``` r
   Mode   FALSE    TRUE    NA's 
logical    1326       1       0
```
``` r 
summary(restData$zipCode < 0)
```
``` r
   Mode   FALSE    TRUE    NA's 
logical    1326       1       0
```
``` r 
table(restData$zipWrong, restData$zipCode < 0)
```
``` r       
        FALSE TRUE
  FALSE  1326    0
  TRUE      0    1
```

## Creating categorical (quantitative) variables

``` r
restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
summary(restData$zipGroups)
```
``` r
(-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] 
                  337                   375                   282 
(2.123e+04,2.129e+04]                  NA's 
                  332                     1 
```
``` r
table(restData$zipGroups, restData$zipCode)
```
``` r                       
                        -21226 21201 21202 21205 21206 21207 21208 21209 21210
  (-2.123e+04,2.12e+04]      0   136   201     0     0     0     0     0     0
  (2.12e+04,2.122e+04]       0     0     0    27    30     4     1     8    23
  (2.122e+04,2.123e+04]      0     0     0     0     0     0     0     0     0
  (2.123e+04,2.129e+04]      0     0     0     0     0     0     0     0     0
                       
                        21211 21212 21213 21214 21215 21216 21217 21218 21220
  (-2.123e+04,2.12e+04]     0     0     0     0     0     0     0     0     0
  (2.12e+04,2.122e+04]     41    28    31    17    54    10    32    69     0
  (2.122e+04,2.123e+04]     0     0     0     0     0     0     0     0     1
  (2.123e+04,2.129e+04]     0     0     0     0     0     0     0     0     0
                       
                        21222 21223 21224 21225 21226 21227 21229 21230 21231
  (-2.123e+04,2.12e+04]     0     0     0     0     0     0     0     0     0
  (2.12e+04,2.122e+04]      0     0     0     0     0     0     0     0     0
  (2.122e+04,2.123e+04]     7    56   199    19     0     0     0     0     0
  (2.123e+04,2.129e+04]     0     0     0     0    18     4    13   156   127
                       
                        21234 21237 21239 21251 21287
  (-2.123e+04,2.12e+04]     0     0     0     0     0
  (2.12e+04,2.122e+04]      0     0     0     0     0
  (2.122e+04,2.123e+04]     0     0     0     0     0
  (2.123e+04,2.129e+04]     7     1     3     2     1
```

## Easier cutting

``` r 
library(Hmisc) # has cut2
restData$zipGroups <- cut2(restData$zipCode, g=4) # g is nbr of quantile grps
summary(restData$zipGroups)
```
``` r
[-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
           338            375            300            314 
```

## Creating factor variables

``` r
# Zip code is integer but not quantitative
# Make it a factor!
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
```
``` r
 [1] 21206 21231 21224 21211 21223 21218 21205 21211 21205 21231
32 Levels: -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 ... 21287
```
``` r
class(restData$zcf)
```
``` r
[1] "factor"
```

## Levels of factor variables

``` r
yesno <- sample(c("yes", "no"), size=10, replace=T)
yesnofac <- factor(yesno) # By default, is alphabetical (no=1, yes=2)
yesnofac
as.numeric(yesnofac)
```
``` r
 [1] no  no  no  no  yes no  yes yes yes no 
Levels: no yes
 [1] 1 1 1 1 2 1 2 2 2 1
```
``` r 
yesnofac <- factor(yesno, levels=c("yes", "no")) # To override default sorting
yesnofac
as.numeric(yesnofac) # Now no=2, yes=1
```
``` r
 [1] no  no  no  no  yes no  yes yes yes no 
Levels: yes no
 [1] 2 2 2 2 1 2 1 1 1 2
```
``` r
yesnofac <- relevel(yesnofac, ref="yes") # Another way, but can only spec lvl 1
yesnofac
as.numeric(yesnofac)
```
``` r
 [1] no  no  no  no  yes no  yes yes yes no 
Levels: yes no
 [1] 2 2 2 2 1 2 1 1 1 2
```

## Cutting produces factor variables!

``` r
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
class(restData$zipGroups)
```
``` r
[1] "factor"
```

## Using the mutate function to create and add in a single function

``` r
library(Hmisc)
library(plyr)
restData2 <- mutate(restData, zipGroups=cut2(zipCode, g=4))
summary(restData2$zipGroups)
```
``` r
[-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
           338            375            300            314 
```

## Common transforms
- `abs(x)` absolute value
- `sqrt(x)` square root
- `ceiling(x)` round up
- `floor(x)` round down
- `round(x, digits=n)`
- `signif(x, digits=n)` round to significant digits
- `cos(x)`, `sin(x)`, etc.
- `log(x)` - **natural** logarithm
- `log1(x)`, `log10(x)`, and other common logs
- `exp(x)` exponentiating x

#### [http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf) 
#### [http://statmethods.net/management/functions.html](http://statmethods.net/management/functions.html)

## Notes and further reading

- A tutorial from the developer of _plyr_ - [http://plyr.had.co.nz/09-user/](http://plyr.had.co.nz/09-user/)
- Andrew Jaffe's R notes [http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf)