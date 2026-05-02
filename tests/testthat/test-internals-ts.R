test_that("ts_to_df preserves custom attributes", {
  skip_if_not_installed("tsbox")
  x <- ts(1:10, start=c(2020,1), frequency=4)
  attr(x, "scale") <- "log"
  attr(x, "transform") <- "diff"

  df <- visdat:::ts_to_df(x)
  expect_equal(attr(df, "scale"), "log")
  expect_equal(attr(df, "transform"), "diff")
})

test_that("ts_to_df handles length > 1 names correctly", {
  skip_if_not_installed("tsbox")
  x <- ts(1:10, start=c(2020,1), frequency=4)
  names(x) <- c("a", "b", "c")

  df <- visdat:::ts_to_df(x)
  expect_s3_class(df, "data.frame")
})
