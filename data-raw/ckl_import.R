## code to prepare `ckl_import` dataset goes here
library(readxl)
library(here)
library(dplyr)
library(devtools)
library(rgnparser)
library(stringr)
library(tidyr)

### read checklist data, accepted names first, and rename some columns so as to remove spaces from 
### column names. Also, remove any ambiguous names as well as duplicates
file_in <- "CKL_27_04_2023.xlsx"
sheet_ckl <- "Checklist"
sheet_syn <- "Sinonimi"
n_textcols <- 40
ckl_data <- readxl::read_xlsx(path=here("data-raw",file_in),sheet = sheet_ckl,
                              col_types = c("numeric",
                                            rep("text", n_textcols))) %>%
  dplyr::rename(codice_unico = 1,famiglia_checklist = 2, entita = 8, status_naz_aliene = 35,
         taraxacum_sezioni = 37, rilevanza_unionale = 38, lista_rossa = 39) %>%
  dplyr::filter(!grepl(pattern = ".+auct\\..+p\\.p\\.", x = entita)) %>% ### remove ambiguous names
  unique()                                                               ### remove duplicates


### read checklist synonyms and rename some columns so as to match those in ckl_data,
### then remove ambiguous names (preceded by ? or whose authority starts with auct.).
### In addition, take care of wrong synonym carried over from the xlsx file.
### Finally, remove duplicates
ckl_synon <- readxl::read_xlsx(path=here("data-raw",file_in), sheet = sheet_syn,
                               col_types = c("numeric","text","text")) %>%
  dplyr::rename("codice_unico" = 1, entita = 2) %>%
  dplyr::filter(!grepl(pattern = ".+auct\\.", x = sinonimo)) %>%
  dplyr::filter(!grepl(pattern = "^\\?.+",x = sinonimo)) %>%
  dplyr::filter(!grepl("^Sesleria apennina Ujhelyi$", sinonimo)) %>% ### remove wrong synonym lurking in the current xlsx file
  unique()                                                           ### remove duplicates

### create a single dataframe with synonyms and accepted names. Remove duplicates
ckl_names <- select(ckl_data,1,8) %>% mutate(sinonimo = entita) %>% bind_rows(ckl_synon) %>% unique()

### parse names
all_names <- ckl_names$sinonimo ### vector to be parsed
ckl_parsed <- superparse(all_names) %>%
  filter(quality > 0, quality < 4, cardinality > 1, cardinality < 4) ### dataframe with parsed names

### write to data
usethis::use_data(ckl_names, ckl_data, ckl_parsed, overwrite = TRUE)
