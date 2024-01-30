### zzz.R
### set up onload function
#' @import httr
#' @import jsonlite

.onAttach <- function(libname,pkgname) {

  remote_version <- get_remote_version()

  local_version <- get_local_version()

  packageStartupMessage("This is package floritaly version ", local_version, ". ")
  if(local_version != remote_version) {
    packageStartupMessage("Please run devtools::install_github('gibedini/floritaly') to install the latest version (", remote_version, ").")
  } else {
    packageStartupMessage("You are running the latest version (",local_version, ").")
  }
}

get_remote_version <- function() {
  # fetch checklist version from server
  version <-httr::GET('https://dryades.units.it/api_test/floritaly/version')

  # convert from JSON string
  version_data = jsonlite::fromJSON(rawToChar(version$content))

  # transform string to dataframe
  version_df = as.data.frame(version_data)

  # return version number
  return(version_df$version)
}

get_local_version <- function() {

  # load ckl_version dataframe
  utils::data("ckl_version",package = "floritaly", envir = environment())

  return(ckl_version$version)

}
