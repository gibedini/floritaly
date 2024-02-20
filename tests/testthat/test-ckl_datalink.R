o <- floritaly::ckl_datalink()

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("result is a tibble", {
  expect_true(all(class(o) == c("tbl_df", "tbl", "data.frame")))
})
