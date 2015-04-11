library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=T)
rootNode <- xmlRoot(doc)
xmlName(rootNode) # name of root element
names(rootNode) # name of all 1st children
rootNode[[1]] # first child of rootNode (and all decendents)
rootNode[[1]][[1]] # first child of the first child of the root node

xmlSApply(rootNode, xmlValue) # The values, concatenated, of all descendents
                              # of rootNode

# XPath further reading:
# http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf

# gets the values of all "name" nodes, regardless of location
xpathSApply(rootNode, "//name", xmlValue)

# gets the values of all "price" nodes, regardless of location
xpathSApply(rootNode, "//price", xmlValue)

# Extract content by attributes
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=T)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams