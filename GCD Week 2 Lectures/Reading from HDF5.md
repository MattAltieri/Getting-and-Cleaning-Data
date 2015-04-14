## HDF5
- Used for storing large datasets
- Supports storing a range of data types
- Hierarchical data format
- _groups_ containing zero or more datasets and metadata
	- Have a _group header_ with group name and list of attributes
	- Have a _group symbol table_ with a list of objects in group
- _datasets_ multidimensional array of data elements with metadata
	- Have a _header_ with name, datatype, dataspace, and storage layout
	- Have a _data array_ with the data

##### [http://www.hdfgroup.org/](http://www.hdfgroup.org/)

``` r
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created <- h5createFile("example.h5")
created
```

- This will install packages from Bioconductor [http://bioconductor.org/](http://bioconductor.org/), primarily used for genomics but also has good "big data" packages
- Can be used to interface with hdf5 datasets
- This lecture is modeled very closely on the rhdf5 tutoial that can be found here [http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf](http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf)

## Create groups

``` r
created <- h5createGroup("example.h5", "foo")
created <- h5createGroup("example.h5", "baa")
created <- h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")
```

## Write to groups

``` r
A <- matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B <- array(seq(0.1, 2.0, by=0.1), dim=c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
```

## Write a dataset

``` r
df <- data.frame(1L:5L, seq(0, 1, length.out=5),
                 c("ab", "cde", "fghi", "a", "s"), stringsAsFactors=F)
h5write(df, "example.h5", "df")
h5ls("example.h5")
```

## Reading data

``` r
readA <- h5read("example.h5", "foo/A")
readB <- h5read("example.h5", "foo/foobaa/B")
readdf <- h5read("example.h5", "df")
readA
readB
readdf
```

## Writing and reading chunks
#### Overwrites what was previously loaded to loc 1:3

``` r
h5write(c(12, 13, 14), "example.h5", "foo/A", index=list(1:3, 1))
h5read("example.h5", "foo/A")
```

## Notes and further resources
- hdf5 can be used to optimize reading/writing from disc in R
- The rhdf5 tutorial
	- [http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf](http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf)
- The HFG group has information on HDF5 in general [http://www.hdfgroup.org/HDF5/](http://www.hdfgroup.org/HDF5/)