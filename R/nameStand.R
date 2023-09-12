#' Standardize scientific names
#'
#' Standardize scientific names against the Checklist of the Italian flora.
#' The function attempts to find the best matching names against the
#' Checklist of the Italian flora
#' for each item of nvec, a character vector containing the scientific name to
#' match.
#'
#' First, the names are parsed by the \code{superparse} function, an
#' implementation of the rgn_parse that parses each name component; only
#' the names with cardinality 2 or 3 (specific or subspecific/varietal rank respectively)
#' are retained. Parsed names are checked against the parsed names of the Checklist.
#'
#' Then, the function looks for perfect matches,
#' where a full name (with infraspecific qualifier and authorities) in the parsed list
#' matches exactly (verbatim) a name in the parsed checklist;
#'
#' The matched names are then removed from the parsed list and the function looks for
#' an exact match between the full canonical
#' form of the remaining names (i.e. epithets and infraspecific qualifier but
#' no authorities) and the full canonical form of the Checklist.
#'
#' This process is repeated for the simple canonical form (only epithets, no
#' infraspecific qualifier, no authorities) and the stem canonical form (only stem
#' of epithets, no suffix, no infraspecific qualifier, no authorities).
#'
#' The remaining names are then subjected to a fuzzy match with the Checklist,
#' based on a stringdist_inner_join (from package fuzzyjoin) with Levenshtein distance
#' and maximum distance = 1.
#'
#' The yet unmatched names are then split in two groups based on their cardinality:
#' an attempt is made to fuzzy-match species to the respective nominal subspecies,
#' and subspecies to the parent species.
#'
#' All remaining names are classified as unmatched and no further attempt is made
#' to standardize them.
#'
#' At each step, the match type (perfect, full canonical, etc.)
#' and the Levenshtein distance are recorded for each matched name. When names
#' are fuzzy-matched, only one among those with the minimum distance from
#' a Checklist name is selected.
#'
#' Finally, all subsets originated in the above steps are pieced together row-wise.
#'
#' @param nvec a character vector containing the scientific names of plants of the Italian flora
#'
#' @return a dataframe with six columns, as follows:
#'    \enumerate{
#'      \item{\code{myname}: original name in user's list}
#'      \item{\code{closest_match}: the Checklist name with
#'            the least distance from the original name}
#'      \item{\code{distance}: the Levenshtein-Damereau distance
#'            between \code{closest_match} and \code{original_name}}
#'      \item{\code{match_type}: match type, one of
#'            \code{perfect}, \code{full}, \code{simple},
#'            \code{stem}, \code{suboptimal}, \code{species2subspecies},
#'            \code{subspecies2species}, and \code{unmatched} (see above
#'            for an explanation of match types)}
#'      \item{\code{ckl_id}: the unique identifier of the corresponding
#'            accepted name in the Checklist}
#'      \item{\code{accepted_name}: the accepted name corresponding to
#'            \code{closest_match} according to the Checklist}
#'      }
#'
#' @export nameStand
#'
#' @examples my_names <- c("Crocus etruscus Parl.","Santolina pinnata Viv.")
#' s <- nameStand(my_names)
nameStand <- function(nvec) {
  s <- floritaly::superparse(nvec) %>%
    dplyr::filter(quality > 0, quality < 5, cardinality > 1, cardinality < 4)
  s_row <- nrow(s)
  m_exact <- data.frame(jcol = c("verbatim","canonicalfull","canonicalsimple","canonicalstem"),
                        mtyp = c("perfect","full","simple","stem"))
  e_match <- ijoin(ds = s,jcol = m_exact$jcol[1],mtyp =m_exact$mtyp[1])

  for(i in 2:nrow(m_exact)) {
    if(nrow(e_match) == s_row) break
    i_match <- ijoin(ds = xstrain(s,e_match),jcol = m_exact$jcol[i],mtyp =m_exact$mtyp[i])
    e_match <- dplyr::union(e_match, i_match)
  }

  while(nrow(e_match) < s_row) {
    f_match <- fjoin(ds = xstrain(s,e_match), jcol = "canonicalstem", maxdist = 1,
                          mtyp = "suboptimal match", ckl_df = ckl_parsed)
    e_match <- dplyr::union(e_match,f_match)
    if(nrow(e_match) == s_row) break

    nosub_match2 <- xstrain(s,e_match) %>% dplyr::filter(cardinality == 2)
    ckl_parsed2 <- dplyr::filter(ckl_parsed,cardinality == 2)
    nosub_match3 <- xstrain(s,e_match) %>% dplyr::filter(cardinality == 3)
    ckl_parsed3 <- dplyr::filter(ckl_parsed,cardinality == 3)

    f_match <- fjoin(ds = nosub_match3, jcol = c("g_epithet" = "g_epithet",
                                                 "i_epithet" = "s_epithet"),
                     maxdist = 1, mtyp = "sub2sp", ckl_df = ckl_parsed2)
    e_match <- dplyr::union(e_match,f_match)
    unmatched_v <- setdiff(nosub_match3$verbatim,f_match$myname)
    if(nrow(e_match) == s_row) break

    f_match <- fjoin(ds = nosub_match2, jcol = c("g_epithet" = "g_epithet",
                                                 "s_epithet" = "i_epithet"),
                     maxdist = 1, mtyp = "sp2sub", ckl_df = ckl_parsed3)
    e_match <- dplyr::union(e_match,f_match)
    if(nrow(e_match) == s_row) break

    unmatched_v <- c(unmatched_v, setdiff(nosub_match2$verbatim,f_match$myname))
    break
  }

  if(exists("unmatched_v")) {
    unmatched <- dplyr::filter(s,verbatim %in% unmatched_v) %>%
      dplyr::select(verbatim) %>% dplyr::rename(myname = verbatim) %>%
      dplyr::mutate(closest_match = '', distance = 99, match_type = "unmatched")
    closest_match <- dplyr::union(e_match,unmatched)
    cat(nrow(unmatched),"names remain unmatched\n")
  } else {
    closest_match <- e_match
    cat("all",nrow(closest_match), "supplied names have been matched\n")
  }
  cat("name standardization terminated\n")
  cat("retrieving accepted names...\n")
  accepted_match <- dplyr::left_join(closest_match,ckl_names,
                                      by=c("closest_match" = "sinonimo"),
                                     keep = FALSE)

  return(accepted_match)
}

ijoin <- function(ds,jcol,mtyp) {
  cat("Looking for",mtyp,"matches... ")
  ij <- dplyr::inner_join(ds,ckl_parsed,by = jcol, keep = TRUE) %>%
    squeeze_df(., mt = mtyp)
  cat("found ", nrow(ij),"\n")
  return(ij)
}

fjoin <- function(ds,jcol,maxdist,mtyp,ckl_df) {
  cat("Looking for",mtyp,"matches... ")
  fj <- fuzzyjoin::stringdist_inner_join(ds,ckl_df,by = jcol,
                                         max_dist = maxdist, method = "lv",
                                         distance_col ="fuzzydist") %>%
    squeeze_df(., mt = mtyp) %>% pick_mindist()
  cat("found ", nrow(fj), "\n")
  return(fj)
}

squeeze_df <- function(df,mt) {
  ### df is a dataframe with the same columns as one derived from superparse function
  ### and as many rows as dictated by filtering expression in the calling code.
  ### This function selects the original and matched name columns, renames them, and
  ### adds the levenshtein distance between them and the match type passed as mt (a character string)
  dd <- dplyr::select(df, verbatim.x,verbatim.y) %>%
    dplyr::rename(myname = verbatim.x, closest_match = verbatim.y) %>%
    dplyr::mutate(distance = stringdist::stringdist(myname,closest_match,method = "lv"),
                  match_type = mt)
  return(dd)
}

pick_mindist <- function(df) {
  ### df is a dataframe produced by squeeze_df (hence squeezed).
  ### This function finds the rows with minimum distance between a given original name
  ### (in column "myname") and the set of closest_matches fuzzy-joined to it, then picks
  ### only the first row of that set and returns a dataframe with as many rows as the original
  ### names in df
  dd <- dplyr::group_by(df, myname) %>%
    dplyr::slice_min(distance) %>%
    dplyr::slice_head()
  return(dd)
}

xstrain <- function(dfs,dfm) {
  ### determines the difference between two name vectors
  ### and returns a subset of dfs matching the surviving names
  d <- setdiff(dfs$verbatim,dfm$myname)
  return(dplyr::filter(dfs,verbatim %in% d))
}

