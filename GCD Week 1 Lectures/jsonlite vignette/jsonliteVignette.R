# Converting between JSON and R classes
## Atomic vectors
require(jsonlite)
x <- c(1, 2, pi)
cat(toJSON(x))

### Missing Values
x <- c(T, F, NA)
cat(toJSON(x))

x <- c(1, 2, NA, NaN, Inf, 10)
cat(toJSON(x))

cat(toJSON(c(T, NA, NA, F)))
cat(toJSON(c("FOO", "BAR", NA, "NA")))
cat(toJSON(c(3.14, NA, NaN, 21, Inf, -Inf)))
cat(toJSON(c(3.14, NA, NaN, 21, Inf, -Inf), na="null")) # Overrides default

### Special vector types: dates, times, factor, comples
### By default, coerces them to string
cat(toJSON(Sys.time() + 1:3))
cat(toJSON(as.Date(Sys.time()) + 1:3))
cat(toJSON(complex(real=runif(3), imaginary=rnorm(3))))

### Special cases: vectors of length 0 or 1 - edge cases
cat(toJSON(vector()))
cat(toJSON(pi))
cat(toJSON(list(pi)))

## Matricies
x <- matrix(1:12, nrow=3, ncol=4)
print(x)
print(x[2, 4])
cat(toJSON(x))

x <- matrix(c(1, 2, 4, NA), nrow=2)
cat(toJSON(x))
cat(toJSON(x, na="null"))
cat(toJSON(matrix(pi)))

### Matrix row and column names
#### This representation is untidy
#### The column and row names are really values that tell you something about
#### the numeric data
x <- matrix(c(NA, 1, 2, 5, NA, 3), nrow=3)
row.names(x) <- c("Joe", "Jane", "Mary")
colnames(x) <- c("Treatment A", "Treatment B")
print(x)

#### So it would be better to "melt" them, or unpivot them into values rather
#### than variable (column) or observation (row) names
library(reshape2)
y <- melt(x, varnames=c("Subject", "Treatment"))
print(y)

#### jsonlite won't store column and row names, so melting is good to do
#### before converting toJSON
cat(toJSON(y, pretty=T))

#### If the field names in the matrix do truly contain variable names and
#### not values, it's better to convert to a data frame
cat(toJSON(as.data.frame(x), pretty=T))

## Lists
### Named list
mylist1 <- list(foo=123, bar=456)
print(mylist1$bar)
### Unnamed list
mylist2 <- list(123, 456)
print(mylist2[[2]])

### Unnamed lists to JSON
cat(toJSON(list(c(1, 2), "test", T, list(c(1, 2)))))
### In the case of unnamed lists, the original list and the fromJSON output
### should be identical
x <- list(c(1, 2.11, NA), "test", FALSE, list(foo = "bar"))
identical(fromJSON(toJSON(x)), x)
### The only exceptions are numeric vectors which get simplified to integers
### by fromJSON, and empty lists & vectors, which are both encoded as [ ]

### Named lists to JSON
cat(toJSON(list(foo=c(1, 2), bar="test")))
cat(toJSON(list(foo=list(bar=list(baz=pi)))))
### This mapping is almost perfect, with one exception... R list objects can
### have empty names
x <- list(foo=123, "test", T)
attr(x, "names")
### JSON however must have valid names in the key/value pairs in object. So,
### like the R Print function, jsonlite falls back on using list indices
### for the key names
cat(toJSON(x))

## Data frame
is(iris)
names(iris)
print(iris[1:3, c(1, 5)])
print(iris[1:3, c("Sepal.Width", "Species")])

### Row-based data frame encoding
cat(toJSON(iris[1:2,], pretty=T))
### Notice  that the value fields are JSON primatives rather than the arrays
### and objects used by jsonlite when converting lists
cat(toJSON(list(list(Species="Foo", Width=21)), pretty=T))

### Key point!
#### Primatives in an array in JSON indicate the source from R was a vector
#### Primatives in an object in JSON indicate the source from R was a data
#### frame row
#### A jsonlite-encoded list will NEVER contain primatives

#### In addition to string-based encoding or using JSON nulls to represent
#### missing values, when converting data frames there is a third option:
#### Don't include the variable for that record. For example
x <- data.frame(foo=c(F, T, NA, NA), bar=c("Aladdin", NA, NA, "Mario"))
print(x)
cat(toJSON(x, pretty=T))
#### This is the default behavior

### Relational data:  nested records
#### When encountering subrecords in JSON, jsonlite will map this to nested
#### data frames. For example:
options(stringsAsFactors=F)
x <- data.frame(driver=c("Bowser", "Peach"),
                occupation=c("Koopa", "Princess"))
x$vehicle <- data.frame(model=c("Piranha Prowler", "Royal Racer"))
x$vehicle$stats <- data.frame(speed=c(55, 34),
                              weight=c(67, 24),
                              drift=c(35, 32))
str(x)
cat(toJSON(x, pretty=T))
#### They should map identically (given the usual caveats about int/num and
#### certain empty elements)
myjson <- toJSON(x)
y <- fromJSON(myjson)
identical(x, y)

#### When the record-subrecord relationship is one-to-one, we can easily
#### flatten the nested data frames into a non-nested data frame.
z <- cbind(x[c("driver", "occupation")], x$vehicle["model"], x$vehicle$stats)
str(z)

### One-to-many relational data
x <- data.frame(author=c("Homer", "Virgil", "Jeroen"))
x$poems <- list(c("Iliad", "Odyssey"),
                c("Eclogues", "Georgics", "Aneid"),
                vector())
names(x)
cat(toJSON(x, pretty=T))

#### Here's as close as R can get
x <- data.frame(author=c("Homor", "Virgil", "Jeroen"))
x$poems <- list(
    data.frame(title=c("Ilead", "Odyssey"), year=c(-1194, -800)),
    data.frame(title=c("Eclogues", "Georgics", "Aeneid"),
               year=c(-44, -29, -19)),
    data.frame()
)

cat(toJSON(x, pretty=T))