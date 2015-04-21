## Subsetting - quick review

``` r
## Subsetting - quick review

set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1, 3)] = NA
X
```
``` r
  var1 var2 var3
1    2   NA   15
4    1   10   11
2    3   NA   12
3    5    6   14
5    4    9   13
```
``` r
X[,1] # Subset a column
```
``` r
[1] 2 1 3 5 4
```
``` r
X[,"var1"] # Subset a column
```
``` r
[1] 2 1 3 5 4
```
``` r
X[1:2,"var2"] # Subset by both rows and columns
```
``` r
[1] NA 10
```
## Subset with logical AND & OR

``` r
X[(X$var1 <= 3 & X$var3 > 11),]
```
``` r
  var1 var2 var3
1    2   NA   15
2    3   NA   12
```
``` r
X[(X$var1 <= 3 | X$var3 > 15),]
```
``` r
  var1 var2 var3
1    2   NA   15
4    1   10   11
2    3   NA   12
```

## Dealing with missing values

``` r
# Subsetting of rows/columns which contain NAs will not work correctly
X[(X$var2 > 8),] # Returns > 8 and NAs
```
``` r
     var1 var2 var3
NA     NA   NA   NA
4       1   10   11
NA.1   NA   NA   NA
5       4    9   13
```
``` r
# Instead, use 'which'
X[which(X$var2 > 8),]
```
``` r
  var1 var2 var3
4    1   10   11
5    4    9   13
```

## Sorting

``` r
sort(X$var1)
```
``` r
[1] 1 2 3 4 5
```
``` r
sort(X$var1, decreasing=T)
```
``` r
[1] 5 4 3 2 1
```
``` r
sort(X$var2, na.last=T)
```
``` r
[1]  6  9 10 NA NA
```

## Ordering the entire data frame based on a variable

``` r
X[order(X$var1),]
```
``` r
  var1 var2 var3
4    1   10   11
1    2   NA   15
2    3   NA   12
5    4    9   13
3    5    6   14
```
``` r
X[order(X$var1, X$var3),]
```
``` r
  var1 var2 var3
4    1   10   11
1    2   NA   15
2    3   NA   12
5    4    9   13
3    5    6   14
```

## Ordering with plyr*

``` r
library(plyr)
arrange(X, var1)
```
``` r
  var1 var2 var3
1    1   10   11
2    2   NA   15
3    3   NA   12
4    4    9   13
5    5    6   14
```
``` r
arrange(X, desc(var1))
```
``` r
  var1 var2 var3
1    5    6   14
2    4    9   13
3    3   NA   12
4    2   NA   15
5    1   10   11
```
> (dplyr is essentially plyr 2.0, which introduces a condenced syntax and chaining)

## Adding rows and columns

``` r
X$var4 <- rnorm(5)
X
```
``` r
  var1 var2 var3        var4
1    2   NA   15  0.62578490
4    1   10   11 -2.45083750
2    3   NA   12  0.08909424
3    5    6   14  0.47838570
5    4    9   13  1.00053336
```

## You can also do this with cbind

``` r
Y <- cbind(X, rnorm(5)) # Binds to the right
Y
```
``` r
  var1 var2 var3        var4   rnorm(5)
1    2   NA   15  0.62578490 -1.0105164
4    1   10   11 -2.45083750  0.6095613
2    3   NA   12  0.08909424  0.5041528
3    5    6   14  0.47838570  1.3798872
5    4    9   13  1.00053336  0.4906615
```
``` r
Y <- cbind(rnorm(5), X) # Binds to the left
Y
```
``` r
    rnorm(5) var1 var2 var3        var4
1  1.4912935    2   NA   15  0.62578490
4 -0.1842727    1   10   11 -2.45083750
2  0.5127249    3   NA   12  0.08909424
3 -0.9409096    5    6   14  0.47838570
5 -0.3808710    4    9   13  1.00053336
```

#### You can also bind rows with rbind in the same way

## Notes and further resources
- R Programming in the Coursera Data Science Track
- Andrew Jaffe's lecture notes [http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf](http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf)