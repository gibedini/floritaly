#' Italian Checklist of Vascular Flora: parsed names
#'
#'
#' A dataset containing the complete list of parsed vascular plant names - accepted and synonyms -
#' recorded in Italy.
#' @docType data
#' @name ckl_parsed
#'
#'
#' @source \url{https://www.dryades.units/floritaly}
#' @format
#' ckl_parsed is a dataframe with parsed names from ckl_names. Parsing is done via rgnparser
#' ckl_parsed contains 9 columns:
#' \describe{
#'  \item{id}{unique identifier of the plant name}
#'  \item{verbatim}{original plant name}
#'  \item{cardinality}{cardinality}
#'  \item{canonicalstem}{canonical name, only stem}
#'  \item{canonicalsimple}{canonical name, only epithets}
#'  \item{canonicalfull}{canonical name with epithets and infraspecific qualifier}
#'  \item{authorship}{authors of plant names}
#'  \item{year}{year}
#'  \item{quality}{parsing quality}
#' }
#'
#'
c("ckl_parsed")
