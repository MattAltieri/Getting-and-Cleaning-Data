# Read from the named range 'womenName' in XLConnectExample3.xlsx (created by
# XLConnectExample3.R)
require(XLConnect)
wb <- loadWorkbook("XLConnectExample3.xlsx", create=T)
data <- readNamedRegion(wb, name="womenName")
data