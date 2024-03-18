### ckl_datalink.R
#' Link scientific names to regional distribution data
#'
#' @param n this parameter can be either a vector of scientific names
#' to link to regional distribution, or a dataframe returned by the
#' \code{nameStand} function. Anything else will throw an error.
#' The default value is "Crocus etruscus Parl."
#'
#' @return a dataframe with n columns:
#'    \enumerate{
#'      \item{\code{myname}: original name in user's list}
#'      \item{\code{closest_match}: the Checklist name with
#'            the least distance from the original name}
#'      \item{\code{full_distance}: the Levenshtein-Damereau distance
#'            between \code{closest_match} and \code{original_name}}
#'      \item{\code{epithet_distance}: the Levenshtein-Damereau distance
#'            between the \code{full canonical form} of the \code{closest_match}
#'            and the \code{full canonical form} of the \code{original_name}}
#'      \item{\code{match_type}: match type, one of
#'            \code{perfect}, \code{full}, \code{simple},
#'            \code{stem}, \code{suboptimal}, \code{species2subspecies},
#'            \code{subspecies2species}, and \code{unmatched} (see above
#'            for an explanation of match types)}
#'      \item{\code{ckl_id}: the unique identifier of the corresponding
#'            accepted name in the Checklist}
#'      \item{\code{accepted_name}: the accepted name corresponding to the
#'            \code{closest_match} according to the Checklist}
#'.     \item{\code{famiglia_checklist}}: {character, botanical family of the plant name}
#'      \item{\code{END}}: {character, it states whether the species is endemic to Italy or not}
#'      \item{\code{c}}: {character}
#'      \item{\code{ESO}}: {character, is the species alien?}
#'      \item{\code{CULTON_FERAL}}: {character, is the species culton/feral?}
#'      \item{\code{T}}: {character}
#'      \item{\code{ABR}}: {character, status in Abruzzo}
#'      \item{\code{BAS}}: {character, status in Basilicata}
#'      \item{\code{CAL}}: {character, status in Calabria}
#'      \item{\code{CAM}}: {character, status in Campania}
#'      \item{\code{EMR}}: {character, status in Emilia-Romagna}
#'      \item{\code{FVG}}: {character, status in Friuli-Venezia-Giulia}
#'      \item{\code{LAZ}}: {character, status in Lazio}
#'      \item{\code{LIG}}: {character, status in Liguria}
#'      \item{\code{LOM}}: {character, status in Lombardia}
#'      \item{\code{MAR}}: {character, status in Marche}
#'      \item{\code{MOL}}: {character, status in Molise}
#'      \item{\code{PIE}}: {character, status in Piemonte}
#'      \item{\code{PUG}}: {character, status in Puglia}
#'      \item{\code{SAR}}: {character, status in Sardegna}
#'      \item{\code{SIC}}: {character, status in Sicilia}
#'      \item{\code{TAA}}: {character, status in Trentino-Alto Adige}
#'      \item{\code{TOS}}: {character, status in Toscana}
#'      \item{\code{UMB}}: {character, status in Umbria}
#'      \item{\code{VDA}}: {character, status in Valle d'Aosta}
#'      \item{\code{VEN}}: {character, status in Veneto}
#'      \item{\code{P}}: {character}
#'      \item{\code{NC}}: {character, identifies species with old, unconfirmed records}
#'      \item{\code{EX}}: {character, identifies extinct species}
#'      \item{\code{D}}: {character}
#'      \item{\code{DD}}: {character}
#'      \item{\code{NP}}: {character, identifies absent species}
#'      \item{\code{status_naz_aliene}}: {character, alien status in Italy}
#'      \item{\code{Note}}: {character, notes}
#'      \item{\code{taraxacum_sezioni}}: {character, section of Taraxacum}
#'      \item{\code{rilevanza_unionale}}: {character, identifies invasive species of UE concern}
#'      \item{\code{lista_rossa}}: {character, IUCN risk category in the national Red List}
#'      \item{\code{Criteri Lista Rossa Italiana}}: {IUCN category in the Italian Red List of Vascular Plants}
#'      \item{\code{tipologia assessment}}: {}
#' }
#'
#' @export ckl_datalink
#'
#' @examples
#' c <- ckl_datalink()
ckl_datalink <- function(n=c("Crocus etruscus Parl.")) {
  my_colnames <- c("myname",
                   "closest_match",
                   "full_distance",
                   "epithet_distance",
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

  return(dplyr::left_join(sn,floritaly::ckl_data,by=c("ckl_id"="codice_unico")) %>%
           dplyr::select(-entita))

}
