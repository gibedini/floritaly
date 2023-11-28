
# prendi la versione della checklist dal server
version <-httr::GET('https://dryades.units.it/api_test/floritaly/version')

# leggo il contenuto della risposta in json
version_data = fromJSON(rawToChar(version$content))

# lo trasformo in un dataframe
ckl_version = as.data.frame(version_data)

# prendi i dati della checklist dal server
ckl <-httr::GET('https://dryades.units.it/api_test/floritaly/checklist')

# leggo il contenuto della risposta in json
ckl_data = fromJSON(rawToChar(ckl$content))

# lo trasformo in un dataframe
ckl_data = as.data.frame(ckl_data)
# nota l'api non può restituire valori NA ma solo stringhe vuote, se vuoi na
ckl_data[ckl_data == ''] <- NA


# prendi i nomi dal server
names <-httr::GET('https://dryades.units.it/api_test/floritaly/names')

# leggo il contenuto della risposta in json
names_data = fromJSON(rawToChar(names$content))

# lo trasformo in un dataframe
ckl_names = as.data.frame(names_data)


# prendi i nomi parsed dal server
parsed <-httr::GET('https://dryades.units.it/api_test/floritaly/parsedchecklist')

# leggo il contenuto della risposta in json
parsed_data = fromJSON(rawToChar(parsed$content))

# lo trasformo in un dataframe
ckl_parsed = as.data.frame(parsed_data)

### write to data
usethis::use_data(ckl_version, ckl_names, ckl_data, ckl_parsed, overwrite = TRUE)





