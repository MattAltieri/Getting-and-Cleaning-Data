# Write the Women dataset into a named range in a new Excel workbook.
require(XLConnect)
wb <- loadWorkbook("XLConnectExample3.xlsx", create=T)
createSheet(wb, name="womenData")
createName(wb, name="womenName", formula="womenData!$C$5", overwrite=T)
writeNamedRegion(wb, women, name="womenName")
saveWorkbook(wb)