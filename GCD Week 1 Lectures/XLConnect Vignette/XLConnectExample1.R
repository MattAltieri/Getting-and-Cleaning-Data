# Write the ChickWeight dataset into a new Excel workbook.
require(XLConnect)
wb <- loadWorkbook("XLConnectExample1.xlsx", create=T)
createSheet(wb, name="chickSheet")
writeWorksheet(wb, ChickWeight, sheet="chickSheet", startRow=3,
               startCol=4)
saveWorkbook(wb)