# Read from the named range 'womenName' in XLConnectExample3.xlsx (created by
# XLConnectExample3.R) in one call
require(XLConnect)
data <- readNamedRegionFromFile("XLConnectExample4.xlsx", "womenName")
data