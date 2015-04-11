# install.packages("xlsx")
library(xlsx)
# if rJava error occurs, the Windows PATH variable needs 
# to be pointed to the right jvm.dll file from the JRE.
# Usually in something like C:\Program Files\Java\jre1.8.0_31\bin\server\

if (!file.exists(".\\data")) { dir.create(".\\data") }
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile=".\\data\\cameras.xlsx", mode="wb")
dateDownloaded <- date()

cameraData <- read.xlsx(".\\data\\cameras.xlsx", sheetIndex=1, header=T)
head(cameraData)

colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx(".\\data\\cameras.xlsx", sheetIndex=1,
                              colIndex=colIndex,rowIndex=rowIndex)
cameraDataSubset