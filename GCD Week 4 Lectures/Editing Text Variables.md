# Editing Text Variables
## Example - Baltimore camera data
![](cameras.png)
[https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru](https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru)

## Fixing character vectors - `tolower()`, `toupper()`
``` r
if (!file.exists("./data")) { dir.create("./data") }
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true"
download.file(fileUrl, destfile="./data/camera.csv")
cameraData <- read.csv("./data/camera.csv")
names(cameraData)
```
``` r
[1] "ï..address"   "direction"    "street"       "crossStreet"  "intersection"
[6] "Location.1"  
```
``` r
tolower(names(cameraData))
```
``` r
[1] "ï..address"   "direction"    "street"       "crossstreet"  "intersection"
[6] "location.1"  
```

## Fixing character vectors - `strsplit()`
- Good for automatically splitting variable names
- Important parameters _x_, _split_

``` r
splitNames <- strsplit(names(cameraData), "\\.")
splitNames[[5]]
```
``` r
[1] "intersection"
```
``` r
splitNames[[6]]
```
``` r
[1] "Location" "1"
```

## Quick aside - lists
``` 
mylist <- list(letters=c("A", "b", "c"), numbers=(1:3), matrix(1:25, ncol=5))
head(mylist)
```
``` r
$letters
[1] "A" "b" "c"

$numbers
[1] 1 2 3

[[3]]
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    6   11   16   21
[2,]    2    7   12   17   22
[3,]    3    8   13   18   23
[4,]    4    9   14   19   24
[5,]    5   10   15   20   25
```

[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf)

``` r
mylist[1]
```
``` r
$letters
[1] "A" "b" "c"
```
``` r
mylist$letters
```
``` r
[1] "A" "b" "c"
```
``` r
mylist[[1]]
```
``` r
[1] "A" "b" "c"
```

[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf)

## Fixing character vectors - `sapply()`
- Applied a function to each element in a vector or list
- Important parameters _x_, _FUN_

``` r
splitNames[[6]][1]
```
``` r
[1] "Location"
```
``` r
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)
```
``` r
[1] "ï"            "direction"    "street"       "crossStreet"  "intersection"
[6] "Location"
```

## Peer review experiment data
![](cooperation.png)
[http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0026895](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0026895)

## Peer review data
``` r
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./data/reviews.csv")
download.file(fileUrl2, destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews, 2)
```
``` r
  id solution_id reviewer_id      start       stop time_left accept
1  1           3          27 1304095698 1304095758      1754      1
2  2           4          22 1304095188 1304095206      2306      1
```
``` r
head(solutions, 2)
```
``` r
  id problem_id subject_id      start       stop time_left answer
1  1        156         29 1304095119 1304095169      2343      B
2  2        269         25 1304095119 1304095183      2329      C
```

## Fixing character vectors() - `sub()`
- Important parameters _pattern_, _replacement_, _x_

``` r
names(reviews)
```
``` r
[1] "id"          "solution_id" "reviewer_id" "start"       "stop"       
[6] "time_left"   "accept"     
```
``` r
sub("_", "", names(reviews), )
```
``` r
[1] "id"         "solutionid" "reviewerid" "start"      "stop"       "timeleft"  
[7] "accept" 
```

## Fixing character vectors - `gsub()`
``` r
testName <- "this_is_a_test"
sub("_", "", testName)
```
``` r
[1] "thisis_a_test"
```
``` r
gsub("_", "", testName)
```
``` r
[1] "thisisatest"
```

## Finding values - `grep()`, `grepl()`
``` r
grep("Alameda", cameraData$intersection)
```
``` r
[1]  4  5 36
```
``` r
table(grepl("Alameda", cameraData$intersection))
```
``` r
FALSE  TRUE 
   77     3 
```
``` r
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
```

## More on `grep()`
``` r
grep("Alameda", cameraData$intersection, value=T)
```
``` r
[1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"   
[3] "Harford \n & The Alameda"
```
``` r
grep("JeffStreet", cameraData$intersection)
``` 
``` r
integer(0)
```
``` r
length(grep("JeffStreet", cameraData$intersection))
```
``` r
[1] 0
```

[http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf)

## More useful string functions
``` r
library(stringr)
nchar("Jeffrey Leek")
```
``` r
[1] 12
```
``` r
substr("Jeffrey Leek", 1, 7)
```
``` r
[1] "Jeffrey"
```
``` r
paste("Jeffrey", "Leek")
```
``` r
[1] "Jeffrey Leek"
```
``` r
paste0("Jeffrey", "Leek")
```
``` r
[1] "JeffreyLeek"
```
``` r
str_trim("Jeff        ")
```
``` r
[1] "Jeff"
```

## Important points about text in data sets
- Names of variables should be
	- All lower case when possible (I disagree!)
	- Descriptive (Diagnosis vs Dx)
	- Not duplicated
	- Not have underscores or dots or white spaces
- Variables with character values
	- Should usually be made into factor variables (depends on application)
	- Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female vs 0/1 or M/F 