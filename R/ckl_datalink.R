### ckl_datalink.R
#' Link scientific names to regional distribution data
#'
#' @param n this parameter can be either a vector of scientific names
#' to link to regional distribution, or a dataframe returned by the
#' \code{nameStand} function. Anything else will throw an error.
#' The default value is "Crocus etruscus Parl."
#'
#' @return a dataframe with n columns
#' @export ckl_datalink
#'
#' @examples
#' c <- ckl_datalink()
ckl_datalink <- function(n=c("Crocus etruscus Parl.")) {
  my_colnames <- c("myname",
                   "closest_match",
                   "distance",
                   "match_type",
                   "ckl_id",
                   "accepted_name")
  if(is.vector(n) & typeof(n) == "character") {
    sn <- floritaly::nameStand(n)
  } else {
    if(is.data.frame(n) & all(names(n)) == my_colnames) {
      sn <- n
    } else {
      e_msg1 <- "No data could be linked due to malformed 'n' parameter."
      e_msg2 <- "Parameter 'n' must be either a vector of species names or"
      e_msg3 <- "a dataframe resulting from the 'nameStand()' function."
      e_msg <- paste0(e_msg1,"\n",e_msg2, " ", e_msg3)
      stop(e_msg)
    }
  }

  return(dplyr::left_join(sn,floritaly::ckl_data,by="codice_unico"))

}
