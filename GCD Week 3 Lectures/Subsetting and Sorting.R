## Subsetting - quick review

set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X
X <- X[sample(1:5),]
X
X$var2[c(1, 3)] = NA
X

X[,1] # Subset a column

X[,"var1"] # Subset a column

X[1:2,"var2"] # Subset by both rows and columns

## Subset with logical AND & OR

X[(X$var1 <= 3 & X$var3 > 11),]

X[(X$var1 <= 3 | X$var3 > 15),]

## Dealing with missing values

# Subsetting of rows/columns which contain NAs will not work correctly
X[(X$var2 > 8),] # Returns > 8 and NAs

# Instead, use 'which'
X[which(X$var2 > 8),]

## Sorting

sort(X$var1)

sort(X$var1, decreasing=T)

sort(X$var2, na.last=T)

## Ordering the entire data frame based on a variable

X[order(X$var1),]

X[order(X$var1, X$var3),]

## Ordering with plyr
library(plyr)
arrange(X, var1)

arrange(X, desc(var1))

## Adding rows and columns

X$var4 <- rnorm(5)
X

## You can also do this with cbind

Y <- cbind(X, rnorm(5)) # Binds to the right
Y

Y <- cbind(rnorm(5), X) # Binds to the left
Y

#### You can also bind rows with rbind in the same way