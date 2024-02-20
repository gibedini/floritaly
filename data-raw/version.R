## code to prepare `version` dataset goes here

library(httr)
library(jsonlite)

# fetch checklist version from server
version <-httr::GET('https://dryades.units.it/api_test/floritaly/rversion')

# convert from JSON string
version_data0 = fromJSON(rawToChar(version$content))

ckl_version <- data.frame(major = 1, minor = as.numeric(version_data0), patch = 0)
# transform string to dataframe

usethis::use_data(ckl_version, overwrite = TRUE)
