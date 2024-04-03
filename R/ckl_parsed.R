#' Italian Checklist of Vascular Flora: parsed names
#'
#'
#' A dataset containing the complete list of parsed vascular plant names -
#' accepted and synonyms - recorded in Italy.
#' @docType data
#' @name ckl_parsed
#'
#'
#' @source \url{https://www.dryades.units/floritaly/}
#' @format ckl_parsed is a dataframe with parsed names from ckl_names. Parsing
#' is done via rgnparser ckl_parsed contains 19 columns:
#' \enumerate{
#'  \item{id}: {unique identifier of the plant name}
#'  \item{verbatim}: {original plant name}
#'  \item{cardinality}: {cardinality}
#'  \item{canonicalstem}: {canonical name, only stem}
#'  \item{canonicalsimple}: {canonical name, only epithets}
#'  \item{canonicalfull}: {canonical name with epithets and infraspecific qualifier}
#'  \item{authorship}: {authors of plant names}
#'  \item{year}: {year}
#'  \item{quality}: {parsing quality}
#'  \item{g_epithet}: {generic epithet of the orginal name}
#'  \item{s_epithet}: {specific epithet of the original name}
#'  \item{i_qualif}: {infraspecific rank name}
#'  \item{binend}: {end position of specific combination in the original name}
#'  \item{i_qualstart}: {start position of infraspecific rank name}
#'  \item{i_qualend}: {end position of infraspecific rank name}
#'  \item{s_author}: {author of specific combination}
#'  \item{i_epithet}: {infraspecific epithet}
#'  \item{i_epitend}: {end position of infraspecific epithet in the original name}
#'  \item{i_author}: {author of infraspecific combination}
#' }
#'
#'
c("ckl_parsed")
