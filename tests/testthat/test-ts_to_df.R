context("ts_to_df edge cases")

test_that("ts_to_df handles series_name with length > 1", {
  x <- ts(1:10)
  names(x) <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")
  df <- ts_to_df(x)
  expect_s3_class(df, "data.frame")
})

test_that("ts_to_df handles series_name as NA", {
  x <- ts(1:10)
  names(x) <- NA
  df <- ts_to_df(x)
  expect_s3_class(df, "data.frame")
})
