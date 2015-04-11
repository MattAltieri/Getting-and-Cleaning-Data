# Read from XLConnectExample1.xlsx (created by XLConnectExample1.R) in one call
require(XLConnect)
data <- readWorksheetFromFile("XLConnectExample1.xlsx", sheet="chickSheet",
                              startRow=0, endRow=10, startCol=0, endCol=0)
data