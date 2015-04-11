# Write the Women dataset into a named range in a new Excel workbook.
require(XLConnect)
writeNamedRegionToFile("XLConnectExample4.xlsx", women, name="womenName",
                       formula="womenData!$C$5")