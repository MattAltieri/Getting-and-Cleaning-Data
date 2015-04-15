## Getting data off webpages - readLines()

con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con) # Very important!
htmlCode

## Parsing with XML

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//title", xmlValue)

xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

## GET from the httr package

install.packages("httr")
library(httr)
html2 <- GET(url)
content2 <- content(html2, as="text")
parsedHtml <- htmlParse(content2, asText=T)
xpathSApply(parsedHtml, "//title", xmlValue)

## Accessing websites with passwords

library(httr)
pg1 <- GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 <- GET("http://httpbin.org/basic-auth/user/passwd",
           authenticate("user", "passwd"))
pg2

names(pg2)

## Using handles

google <- handle("http://google.com") # Your authentication stays w/ the handle
pg1 <- GET(handle=google, path="/")
pg2 <- GET(handle=google, path="search")