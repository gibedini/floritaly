#' Super parser for scientific names
#'
#' Extracts generic, specific, and infraspecific epithets along with
#' authorship, after parsing with rngparser::gn_parse_tidy
#'
#' @param namevek a character vector containing scientific names
#'
#' @return a dataframe with 15 columns originating from \code{rgnparser::gn_parse_tidy} as
#' well as from the code in this function:
#' \enumerate{
#'  \item{id}:{unique identifier of the plant name}
#'  \item{verbatim}:{original plant name}
#'  \item{cardinality}:{cardinality}
#'  \item{canonicalstem}:{canonical name, only stem}
#'  \item{canonicalsimple}:{canonical name, only epithets}
#'  \item{canonicalfull}:{canonical name with epithets and infraspecific qualifier}
#'  \item{authorship}:{authors of plant names}
#'  \item{year}:{year of publication}
#'  \item{quality}:{parsing quality on a 1-4 scale (1 best, 4 worst)}
#'  \item{g_epithet}:{generic epithet}
#'  \item{s_epithet}:{specific epithet}
#'  \item{s_author}:{author(s) of the binomial combination}
#'  \item{i_qualif}:{infraspecific rank qualifier (e.g. subsp., var.)}
#'  \item{i_epithet}:{infraspecific epithet}
#'  \item{i_author}:{author(s) of the trinomial combination}
#' }
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
  mypnames <- myparsed
  myparsed$g_epithet <- detect_g_epith(mypnames)
  myparsed$s_epithet <- detect_s_epith(mypnames)
  myparsed$s_author <- emptychar
  myparsed$i_qualif <- emptychar
  myparsed$i_epithet <- emptychar
  myparsed$i_author <- emptychar

  myparsed_c2 <- dplyr::filter(myparsed, cardinality == 2)
  myparsed_c3 <- dplyr::filter(myparsed, cardinality == 3)
  myparsed_cx <- dplyr::filter(myparsed, cardinality <= 1 | cardinality >= 4)

  if(nrow(myparsed_c2) > 0) myparsed_c2$s_author <- detect_lastauthor(myparsed_c2)

  if(nrow(myparsed_c3) > 0) {
    myparsed_c3$s_author <- detect_interauthor(myparsed_c3)
    myparsed_c3$i_qualif <- detect_iqualif(myparsed_c3)
    myparsed_c3$i_epithet <- detect_iepithet(myparsed_c3)
    myparsed_c3$i_author <- detect_lastauthor(myparsed_c3)
  }

  myparsed <- dplyr::bind_rows(myparsed_c2,myparsed_c3,myparsed_cx)
  cat("job ended, returning control to main function.")
  return(myparsed)
}

detect_lastauthor <- function(pnames) {
  ### returns the last author of a set of parsed names pnames having cardinality 2 or 3.
  ### It will be the species author for cardinality = 2 and infraspecies author for cardinality = 3
  ### WARNING: it will NOT return the species author of an infraspecific combination (cardinality = 3),
  ### for which the function detect_interauthor must be invoked.
  return(pnames$authorship)
}

detect_interauthor <- function(pnames) {
  ### returns the species author o a set of parsed names pnames having cardinality = 3
  fullword3 <- stringr::word(pnames$canonicalfull,start = 3, end = 3)
  mypattern <- paste0("(^.+)",stringr::str_escape(fullword3),".+$")
  verb3 <- stringr::str_match(pnames$verbatim, mypattern)
  combauth <- verb3[,2]
  combwords <- stringr::str_count(combauth,'[^ ]+')
  interauth <- stringr::word(combauth, start = 3, end = combwords)
  return(stringr::str_trim(interauth))
}

detect_g_epith <- function(pnames) {
  ### returns the generic epithet of a set of parsed names pnames having cardinality 2 or 3
  return(stringr::word(pnames$canonicalsimple, start = 1, end = 1))
}

detect_s_epith <- function(pnames) {
  ### returns the specific epithet of a set of parsed names pnames having cardinality 2 or 3
  return(stringr::word(pnames$canonicalsimple, start = 2, end = 2))
}

detect_iqualif <- function(pnames) {
  ### returns the infraspecific qualifier of a set of parsed names pnames having cardinality = 3
  string_a <- stringr::word(pnames$canonicalsimple, start = 3)
  string_b <- stringr::word(pnames$canonicalfull, start = 3)
  if(string_a == string_b) {
    r <- NA
  } else {
    r <- string_b
  }
  return(r)
}

detect_iepithet <- function(pnames) {
  ### returns the infraspecific epithet of a set of parsed names pnames having cardinality =3
  return(stringr::word(pnames$canonicalsimple, start = 3))
}
