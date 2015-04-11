require(data.table)
DF <- data.frame(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DF, 3)

DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"), each=3), z=rnorm(9))
head(DT, 3)

tables() # all tables in memory

# Subsetting rows
DT[2,]
DT[DT$y=="a",]
DT[c(2, 3)] # Subsetting rows

DT[,c(2, 3)] # Will NOT subset columns

# Calculating values for variables with expressions
DT[,list(mean(x), sum(z))] # Average of x column, sum of z column
DT[,table(y)] # table of all y values

DT[,w:=z^2] # Adding new columns
DT

# Note that changes will propogate to copies
DT2 <- DT
DT[, y:=2]
head(DT)
head(DT2)

# Multi-step operations
DT[,m:={tmp <- (x + z); log2(tmp + 5)}]
DT

# Logical columns (plyr-like)
DT[,a:=x>0]
DT

# OLAP functions!
# Average over column "a""
DT[,b:=mean(x + w), by=a]
DT

# Count over column "x"
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, T))
DT[, .N, by=x] # .N does the calc

# Keys
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x)
DT["a"]

# Joins
DT1 <- data.table(x=c("a", "a", "b", "dt1"), y=1:4)
DT2 <- data.table(x=c("a", "b", "dt2"), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

# Fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=F, col.names=T, sep="\t", quote=F)
system.time(fread(file)) # fastread using data.table
system.time(read.table(file, header=T, sep="\t")) # using data frames

# Diffs between data.table and data.frame
# http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table