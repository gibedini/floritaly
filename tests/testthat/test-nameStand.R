ovec <- c("Crocus etruscus Parl.",           ### perfect match
          "Gladiolus palustris Gaudin",      ### perfect match
          "Santolina pinnata Viv.",          ### perfect match
          "Euphorbia dendroides L.",         ### perfect match
          "Onobrychis caput-galli L.",       ### full canonical match
          "Onobrychis crista-galli L."       ### unmatched name
          )     
ol <- length(ovec)

test_that("number of rows of standardised dataframe equals the length of original name vector", {
  expect_equal(object = nrow(nameStand(ovec)), expected = ol)
})

test_that("number of unmatched rows equals the unmatched original names", {
  expect_equal(object = nrow(dplyr::filter(nameStand(ovec), match_type == "unmatched")), expected = 1)
})

test_that("number of full canonical rows equals the full canonical matches", {
  expect_equal(object = nrow(dplyr::filter(nameStand(ovec), match_type == "full")), expected = 1)
})

