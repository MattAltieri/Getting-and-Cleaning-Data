require(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty=T)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)

# jsonlite tutorial
# http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/

# jsonlite vignette
# http://cran.r-project.org/web/packages/jsonlite/vignettes/json-mapping.pdf