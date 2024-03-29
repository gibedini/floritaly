% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ckl_parsed.R
\docType{data}
\name{ckl_parsed}
\alias{ckl_parsed}
\title{Italian Checklist of Vascular Flora: parsed names}
\format{
ckl_parsed is a dataframe with parsed names from ckl_names. Parsing is done via rgnparser
ckl_parsed contains 9 columns:
\describe{
\item{id}{unique identifier of the plant name}
\item{verbatim}{original plant name}
\item{cardinality}{cardinality}
\item{canonicalstem}{canonical name, only stem}
\item{canonicalsimple}{canonical name, only epithets}
\item{canonicalfull}{canonical name with epithets and infraspecific qualifier}
\item{authorship}{authors of plant names}
\item{year}{year}
\item{quality}{parsing quality}
}
}
\source{
\url{https://www.dryades.units/floritaly}
}
\description{
A dataset containing the complete list of parsed vascular plant names - accepted and synonyms -
recorded in Italy.
}
