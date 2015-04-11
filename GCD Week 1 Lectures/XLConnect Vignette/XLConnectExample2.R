# Write the ChickWeight dataset into a new Excel workbook.
require(XLConnect)
writeWorksheetToFile("XLConnectExample2.xlsx", data=ChickWeight,
                     sheet="chickSheet", startRow=3, startCol=4)