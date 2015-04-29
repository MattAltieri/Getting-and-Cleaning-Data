# Working with Dates
## Starting simple
``` r
d1 <- date()
d1
```
``` r
[1] "Tue Apr 28 19:29:04 2015"
```
``` r 
class(d1)
```
``` r
[1] "character"
```
## Date class
``` r
d2 <- Sys.Date()
d2
```
``` r
[1] "2015-04-28"
```
``` r
class(d2)
```
``` r
[1] "Date"
```

## Formatting dates
`%d` = day as a number (0-31), `%a` = abbreviated weekday, `%A` = unabbreviated weekday, `%m` = month (0-12), `%b` = abbreviated month, `%B` unabbreviated month, `%y` = 2 digit year, `%Y` = four digit year
``` r
format(d2, "%a %b %d")
```
``` r
[1] "Tue Apr 28"
```

## Creating dates
``` r
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z
```
``` r
[1] "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"
```
``` r
z[1] - z[2]
```
``` r
Time difference of -1 days
```
``` r
as.numeric(z[1]-z[2])
```
``` r
[1] -1
```

## Converting to Julian
``` r
weekdays(d2)
```
``` r
[1] "Tuesday"
```
``` r
months(d2)
```
``` r
[1] "April"
```
``` r
julian(d2)
```
``` r
[1] 16553
attr(,"origin")
[1] "1970-01-01"
```

## Lubridate
``` r
library(lubridate)
ymd("20140108")
```
``` r
[1] "2014-01-08 UTC"
```
``` r
mdy("08/04/2013")
```
``` r
[1] "2013-08-04 UTC"
```
``` r
dmy("03-04-2013")
```
``` r
[1] "2013-04-03 UTC"
```
[http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/](http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/)

## Dealing with times
``` r
ymd_hms("2011-08-03 10:15:03")
```
``` r
[1] "2011-08-03 10:15:03 UTC"
```
``` r
ymd_hms("2011-08-03 10:15:03", tz="Pacific/Auckland")
```
``` r
[1] "2011-08-03 10:15:03 NZST"
```
``` r
?Sys.timezone
```
[http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/](http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/)

## Some functions have slightly different syntax
``` r
x <- dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
```
``` r
[1] 3
```
``` r
wday(x[1], label=T)
```
``` r
[1] Tues
Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
```

## Notes and further resources
- More information in this nice lubdridate tutorial [http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/](http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/)
- The lubridate vignette is the same content [http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html](http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html)
- Ultimately you want your dates and times as class `Date` or the classes `POSIXct`, `POSIXlt`. For more information type `?POSIXlt` 