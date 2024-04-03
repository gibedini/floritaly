#' Italian Checklist of Vascular Flora: all data
#'
#'
#' A dataset containing the complete list of accepted vascular plant names
#' recorded in Italy and their distribution data, alien status, conservation status and more.
#' @docType data
#' @name ckl_data
#'
#'
#' @source \url{https://www.dryades.units/floritaly/}
#' @format
#' ckl_data is a dataframe with 41 columns:
#' \enumerate{
#'      \item{\code{codice_unico}}: {numeric, unique identifier of the plant name}
#'      \item{\code{accepted_name}}: {character, the accepted name}
#'.     \item{\code{Famiglia}}: {character, botanical family of the plant name}
#'      \item{\code{endemicita}}: {character: \code{E} states that the species is endemic to Italy, \code{E?}
#'                  that it is doubtfully endemic to Italy, \code{NA} not applicable}
#'      \item{\code{C}}: {character: \code{C} states that the species is
#'                  cryptogenic at national level, \code{NA} not applicable}
#'      \item{\code{esoticita}}: {character, \code{N} states that the species
#'                  is a neophyte, \code{A} an archeophyte, \code{alien} an
#'                  alien species in the whole national territory, \code{NA} not applicable }
#'      \item{\code{CULTON_FERAL}}: {character, \code{CLT} states that the
#'                  species is a culton, \code{FLT} feral (escaped from cultivation),
#'                  \code{NA} neither one}
#'      \item{\code{T}}: {character, \code{T} states that the species is taxonomically
#'                        doubtful in the national territory, \code{NA} not applicable}
#'      \item{\code{ABR}}: {character, status in Abruzzo*}
#'      \item{\code{BAS}}: {character, status in Basilicata*}
#'      \item{\code{CAL}}: {character, status in Calabria*}
#'      \item{\code{CAM}}: {character, status in Campania*}
#'      \item{\code{EMR}}: {character, status in Emilia-Romagna*}
#'      \item{\code{FVG}}: {character, status in Friuli-Venezia-Giulia*}
#'      \item{\code{LAZ}}: {character, status in Lazio*}
#'      \item{\code{LIG}}: {character, status in Liguria*}
#'      \item{\code{LOM}}: {character, status in Lombardia*}
#'      \item{\code{MAR}}: {character, status in Marche*}
#'      \item{\code{MOL}}: {character, status in Molise*}
#'      \item{\code{PIE}}: {character, status in Piemonte*}
#'      \item{\code{PUG}}: {character, status in Puglia*}
#'      \item{\code{SAR}}: {character, status in Sardegna*}
#'      \item{\code{SIC}}: {character, status in Sicilia*}
#'      \item{\code{TAA}}: {character, status in Trentino-Alto Adige*}
#'      \item{\code{TOS}}: {character, status in Toscana*}
#'      \item{\code{UMB}}: {character, status in Umbria*}
#'      \item{\code{VDA}}: {character, status in Valle d'Aosta*}
#'      \item{\code{VEN}}: {character, status in Veneto*}
#'      \item{\code{P}}: {character, status in the national territory*}
#'      \item{\code{NC}}: {character, \code{NC} identifies species with old, unconfirmed records
#'                        in the whole national territory; \code{NA} not applicable}
#'      \item{\code{EX}}: {character, \code{EX} identifies extinct species in the national
#'                        territory, \code{NA} not applicable}
#'      \item{\code{D}}: {character, \code{D} identifies doubtfully occurring species in the
#'                        national territory, \code{NA} not applicable}
#'      \item{\code{DD}}: {character, \code{DD} identifies data deficient species in the
#'                        national territory, \code{NA} not applicable}
#'      \item{\code{NP}}: {character, \code{NP} identifies wrong records, \code{NA} not applicable}
#'      \item{\code{STATUSNAZALIENE}}: {character, alien status in the national territory**}
#'      \item{\code{Note}}: {character, notes}
#'      \item{\code{taraxacum_sezioni}}: {character, sections of Taraxacum}
#'      \item{\code{specie_esotiche_rilevanza_unionale}}: {character, \code{SI} identifies invasive species of
#'                                                        EU concern, \code{NA} not applicable}
#'      \item{\code{Lista_Rossa}}: {character, abbreviated IUCN risk category in the national Red List}
#'      \item{\code{Criteri_Lista_Rossa_Italia}}: {character, IUCN risk category formula}
#'      \item{\code{tipologia assessment}}: {characger, Red List assessment type}
#' }
#'
#' * status in administrative regions can be one of the following:
#' \enumerate{
#'    \item{\code{P}}: {occurring}
#'    \item{\code{D}}: {doubtfully occurring}
#'    \item{\code{NC}}: {no longer recorded (reliable historical record)}
#'    \item{\code{EX}}: {extinct or possibly extinct}
#'    \item{\code{A}}: {alien at regional level}
#'    \item{\code{CAS}}: {alien at regional level casual}
#'    \item{\code{NAT}}: {alien at regional level naturalized}
#'    \item{\code{INV}}: {alien at regional level invasive}
#'    \item{\code{E}}: {endemic}
#'    \item{\code{C}}: {cryptogenic: doubtfully native taxon, whose origin of occurrence in Italy is unknown}
#'    \item{\code{T}}: {taxonomically doubtful}
#'    \item{\code{DD}}: {data deficient at national level}
#'    \item{\code{NP}}: {wrong record}
#' }
#'
#' ** alien status in the national territory can be one of the following:
#' \enumerate{
#'    \item{\code{A}}: {alien at regional level}
#'    \item{\code{CAS}}: {alien at regional level casual}
#'    \item{\code{NAT}}: {alien at regional level naturalized}
#'    \item{\code{INV}}: {alien at regional level invasive}
#' }
#'
c("ckl_data")
