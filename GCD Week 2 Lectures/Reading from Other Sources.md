## There is a package for that

- Roger has a nice video on how there are R packages for most things that you will want to access
- Here I'm going to briefly review a few useful packages
- In general the best way to find out if the R package exists is to Google "data storage mechanism R package"
	- For example "MySQL R package"

## Interacting more directly with files
- file - Open a connection to a text file
- url - Open a connection to a URL
- gzfile - Open a connection to a .gz file
- bzfile - Open a connection to a .bz2 file
- `?connections` for more information
- **Remember to close connections**

## `foreign` package

- Loads data from Minitab, S, SAS, SPSS, Stata, Systat
- Basic functions `read.foo`
	- `read.arff` (Weka)
	- `read.dta` (Stata)
	- `read.mtp` (Minitab)
	- `read.octave` (Octave)
	- `read.spss` (SPSS)
	- `read.xport` (SAS)
- See the help page for more details [http://cran.r-project.org/web/packages/foreign/foreign.pdf](http://cran.r-project.org/web/packages/foreign/foreign.pdf)

## Examples of other database packages

- `RPostgreSQL` provides a DBI-compliant database connection from R.
	- Tutorial: [https://code.google.com/p/rpostgresql/](https://code.google.com/p/rpostgresql/)
	- Help file: [http://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf](http://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf)
- `RODBC` proides interfaces to multiple databases including PostgreSQL, MySQL, Microsoft Access, and SQLite.
	- Tutorial: [http://cran.r-project.org/web/packages/RODBC/vignettes/RODBC.pdf](http://cran.r-project.org/web/packages/RODBC/vignettes/RODBC.pdf)
	- Help File: [http://cran.r-project.org/web/packages/RODBC/RODBC.pdf](http://cran.r-project.org/web/packages/RODBC/RODBC.pdf)
- `RMongo`
	- Example: [http://cran.r-project.org/web/packages/RMongo/RMongo.pdf](http://cran.r-project.org/web/packages/RMongo/RMongo.pdf)
	- Interfaces
		- [http://www.r-bloggers.com/r-and-mongodb/](http://www.r-bloggers.com/r-and-mongodb/)
		- [http://cran.r-project.org/web/packages/rmongodb/rmongodb.pdf](http://cran.r-project.org/web/packages/rmongodb/rmongodb.pdf)

## Reading images

- `jpeg` - [http://cran.r-project.org/web/packages/jpeg/index.html](http://cran.r-project.org/web/packages/jpeg/index.html)
- `readbitmap` - [http://cran.r-project.org/web/packages/readbitmap/index.html](http://cran.r-project.org/web/packages/readbitmap/index.html)
- `png` - [http://cran.r-project.org/web/packages/png/index.html](http://cran.r-project.org/web/packages/png/index.html)
- `EBImage` (Bioconductor) - [http://www.bioconductor.org/packages/2.13/bioc/html/EBImage.html](http://www.bioconductor.org/packages/2.13/bioc/html/EBImage.html)

## Reading GIS data

- `rdgal` - [http://cran.r-project.org/web/packages/rgdal/index.html](http://cran.r-project.org/web/packages/rgdal/index.html)
- `rgeos` - [http://cran.r-project.org/web/packages/rgeos/index.html](http://cran.r-project.org/web/packages/rgeos/index.html)
- `raster` - [http://cran.r-project.org/web/packages/raster/index.html](http://cran.r-project.org/web/packages/raster/index.html)

## Reading music data

- `tuneR` - [http://cran.r-project.org/web/packages/tuneR/](http://cran.r-project.org/web/packages/tuneR/)
- `seewave` - [http://rug.mnhn.fr/seewave/](http://rug.mnhn.fr/seewave/)

