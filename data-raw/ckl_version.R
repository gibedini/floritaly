## code to prepare `ckl_version` dataset goes here

library(httr)
library(jsonlite)

# fetch checklist version from server
version <-httr::GET('https://dryades.units.it/api_test/floritaly/version')

# convert from JSON string
version_data = fromJSON(rawToChar(version$content))

# transform string to dataframe
ckl_version = as.data.frame(version_data)


usethis::use_data(ckl_version, overwrite = TRUE)
