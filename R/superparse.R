#' Super parser for scientific names
#'
#' Extracts generic, specific, and infraspecific epithets along with
#' authorship, after parsing with rngparser::gn_parse_tidy
#'
#' @param namevek a character vector containing scientific names
#'
#' @return a dataframe with many columns
#' @export superparse
#'
#' @examples my_names <- c("Crocus etruscus Parl.","Santolina pinnata Viv.")
#' s <- superparse(my_names)
#'
superparse <- function(namevek) {
  ### parse names
  cat("parsing",length(namevek),"plant names with rgnparser::gn_parse_tidy...\n")
  myparsed <- rgnparser::gn_parse_tidy(namevek)
  cat("parsing completed!\n")
  emptychar <- rep('',nrow(myparsed))
  emptynum <- rep(NA,nrow(myparsed))
  myparsed$g_epithet <- stringr::word(myparsed$canonicalsimple)
  myparsed$s_epithet <- stringr::word(myparsed$canonicalsimple,start = 2)
  myparsed$i_qualif <- emptychar
  myparsed$i_qualif[myparsed$cardinality == 3] <- stringr::word(myparsed$canonicalfull[myparsed$cardinality == 3], start = 3)
  ### find end of binomina
  myparsed$binend <- stringr::str_locate(myparsed$verbatim,pattern = "^[A-Z][a-z]+ [-a-z]+ ")[,2]
  ### find start / end of infraspecific qualifier
  iqm <- stringr::str_locate(myparsed$verbatim, pattern = myparsed$i_qualif)
  myparsed$i_qualstart <- iqm[,1]
  myparsed$i_qualend <- iqm[,2]
  myparsed$s_author <- emptychar
  myparsed$s_author[myparsed$cardinality == 2] <- stringr::word(myparsed$verbatim[myparsed$cardinality == 2],start = 3, end = -1)
  myparsed$i_epithet <- emptychar
  myparsed$i_epithet[myparsed$cardinality == 3] <- stringr::word(myparsed$canonicalsimple[myparsed$cardinality == 3], start = 3)
  myparsed$i_epitend <- emptynum

  h1 <- substr(myparsed$verbatim[myparsed$cardinality == 3],
               start = myparsed$i_qualend[myparsed$cardinality == 3] + 2,
               stop = 999)
  h2 <- myparsed$i_epithet[myparsed$cardinality == 3]
  h3 <- myparsed$i_qualend[myparsed$cardinality == 3] + 1
  
  myparsed$i_epitend[myparsed$cardinality == 3] <- stringr::str_locate(h1,h2)[,2] + h3
  myparsed$s_author[myparsed$cardinality == 3] <- detect_siauth(myparsed[myparsed$cardinality == 3,])
  myparsed$i_author <- emptychar
  myparsed$i_author[myparsed$cardinality == 3] <- detect_iauth(myparsed[myparsed$cardinality == 3,])
  cat("job ended, returning control to main function.")
  return(myparsed)
}


detect_siauth <- function(pnames) {
  ### passed parameters is a dataframe of parsed names with cardinality = 3
  r <- ifelse((pnames$i_qualstart - pnames$binend) > 1,
              substr(pnames$verbatim,start = pnames$binend + 1, stop = pnames$i_qualstart - 1),
              '')
  return(r)
}

detect_iauth <- function(pnames) {
  l <- nchar(pnames$verbatim)
  r <- ifelse(pnames$i_epitend < l,
              substr(pnames$verbatim,start = pnames$i_epitend + 2,stop = l),
              '')
  return(r)
}
