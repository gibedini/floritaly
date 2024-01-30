#' Italian Checklist of Vascular Flora: all data
#'
#'
#' A dataset containing the complete list of accepted vascular plant names 
#' recorded in Italy and their distribution data, alien status, conservation status and more.
#' @docType data
#' @name ckl_data
#' 
#'
#' @source \url{https://www.dryades.units/floritaly}
#' @format
#' ckl_data is a dataframe with 11080 rows and 39 columns:
#' \describe{
#'  \item{codice_unico}{numeric, unique identifier of the plant name}
#'  \item{famiglia_checklist}{character, botanical family of the plant name}
#'  \item{END}{character, it states whether the species is endemic to Italy or not}
#'  \item{c}{character}
#'  \item{ESO}{character, is the species alien?}
#'  \item{CULTON_FERAL}{character, is the species culton/feral?}
#'  \item{T}{character}
#'  \item{entita}{character, accepted plant name}
#'  \item{ABR}{character, status in Abruzzo}
#'  \item{BAS}{character, status in Basilicata}
#'  \item{CAL}{character, status in Calabria}
#'  \item{CAM}{character, status in Campania}
#'  \item{EMR}{character, status in Emilia-Romagna}
#'  \item{FVG}{character, status in Friuli-Venezia-Giulia}
#'  \item{LAZ}{character, status in Lazio}
#'  \item{LIG}{character, status in Liguria}
#'  \item{LOM}{character, status in Lombardia}
#'  \item{MAR}{character, status in Marche}
#'  \item{MOL}{character, status in Molise}
#'  \item{PIE}{character, status in Piemonte}
#'  \item{PUG}{character, status in Puglia}
#'  \item{SAR}{character, status in Sardegna}
#'  \item{SIC}{character, status in Sicilia}
#'  \item{TAA}{character, status in Trentino-Alto Adige}
#'  \item{TOS}{character, status in Toscana}
#'  \item{UMB}{character, status in Umbria}
#'  \item{VDA}{character, status in Valle d'Aosta}
#'  \item{VEN}{character, status in Veneto}
#'  \item{P}{character}
#'  \item{NC}{character, identifies species with old, unconfirmed records}
#'  \item{EX}{character, identifies extinct species}
#'  \item{D}{character}
#'  \item{DD}{character}
#'  \item{NP}{character, identifies absent species}
#'  \item{status_naz_aliene}{character, alien status in Italy}
#'  \item{Note}{character, notes}
#'  \item{taraxacum_sezioni}{character, section of Taraxacum}
#'  \item{rilevanza_unionale}{character, identifies invasive species of UE concern}
#'  \item{lista_rossa}{character, IUCN risk category in the national Red List}
#' }
#'
#'
c("ckl_data")
