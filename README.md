
# floritaly

<!-- badges: start -->
[![Build Status](https://travis-ci.org/gibedini/floritaly.svg?branch=master)](https://travis-ci.org/gibedini/floritaly)
[![GitHub release](https://img.shields.io/github/release/gibedini/floritaly.svg)](https://github.com/gibedini/floritaly/releases)
<!-- badges: end -->

The goal of \code{floritaly} is to provide an easy access to the Checklist of the Italian vascular flora from R. \code{floritaly} presents plant names and associated data in three data frames that can be joined and filtered with the usual panoply provided by the \code{dplyr} package. In addition, \code{floritaly} offers two functions:
\enumerate{
  \item{\code{nameStand()}}: {takes a list of scientific names as input, fuzzy-matches them to Checklist names and retrieves the corresponding accepted names.
This function therefore can match names even when they are misspelled, as is sometimes the case when names are compiled from a variety of sources as e.g. books, papers, herbarium labels, etc. Name matching works only for names at the specific or subspecific/varietal rank. Therefore, any reference to multiple species, as e.g. *Hieracium* sp.pl., will be discarded, as well as sectional ranks as e.g. *Taraxacum* Sect. Palustris. Likewise, combinations with more than three epithets will be discarded. Once the names are matched, the corresponding accepted names are also displayed.}
  \item{\code{ckl_datalink()}}: {takes the result from \code{nameStand()} as input, joins it to \code{ckl_parsed} and returns the associated data including occurrence in administrative regions, IUCN category, and alien status.} 


## Installation

You can install the development version of floritaly from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("plant-data/floritaly")
```

The stable version is available from CRAN and can be installed either via the usual R Studio interface or by typing the following command in the console:

``` r
install.packages("floritaly")
```


## Example

This is a basic example which shows you how to solve a common problem.
Suppose you have stored a floristic list in a data frame \code{flist} where the column \code{sci_name} contains scientific names compiled from several papers, old books, and herbarium labels from different periods. You are interested in the number of species in your list.
Because of its heterogeneous composition, your list is bound to contain many synonyms and possibly misspelled words, either in the epithets or in the authorities. 
Therefore, simply counting the unique values of the column \code{sci_name} will not give the right result, in fact it will most likely overestimate the number of species.
\code{floritaly} can help you obtain the desired result via the following code:

``` r
library(floritaly)
## let's build a toy dataframe
flist <- data.frame(sci_name = c("Agropyron junceum (L.) P.Beauv.", "Elymus farctus (Viv.) Runemark", "Elytrigia mediterranea (Simonet) Produkin", "Tinopyrum junceum (L.) Lowe", "Otanthus maritimus (L.) Hoffmans. & Link", "Achillea marittima (L.) Ehrend & Y. P. Guo subsp. maritima", "Helicrysum stoechas (L.) Moench"),
        habitat = rep("sand dune",7),
        source = c("Bedini, 1994","Ciccarelli, 2003", "Montelucci, 1950", HCI specimen 112-08986a", "Garbari e Del Prete, 1976", "PISA specimen 18907"), "Astuti, 2012")
        
## basic example code

cat("Number of species in raw list:",length(unique(flist$sci_name),"\n")
cat(unique(flist$sci_name),"\n\n")

ns <- nameStand(flist)
cat("Number of species in standardised list:",length(unique(ns$accepted_name),"\n"))
cat(unique(ns$accepted_name),"\n\n")

```

