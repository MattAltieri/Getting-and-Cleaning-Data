# Read from XLConnectExample1.xlsx (created by XLConnectExample1.R)
require(XLConnect)
wb <- loadWorkbook("XLConnectExample1.xlsx", create=T)
data <- readWorksheet(wb, sheet="chickSheet", startRow=0, endRow=10,
                      startCol=0, endCol=0)
data