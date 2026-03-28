context("Time series attribute preservation")

test_that("ts_to_df preserves custom attributes", {
  skip_if_not_installed("xts")
  library(xts)
  x <- xts(1:10, order.by = as.Date("2020-01-01") + 1:10)
  attr(x, "scale") <- "log"
  attr(x, "transform") <- "diff"

  df <- visdat:::ts_to_df(x)

  expect_equal(attr(df, "scale"), "log")
  expect_equal(attr(df, "transform"), "diff")
  expect_true(!is.null(attr(df, "row_labels")))
  expect_s3_class(df, "data.frame")
})

test_that("ts_to_df handles ts and zoo objects", {
  skip_if_not_installed("zoo")
  library(zoo)
  x_zoo <- zoo(1:10, order.by = as.Date("2020-01-01") + 1:10)
  attr(x_zoo, "scale") <- "linear"
  df_zoo <- visdat:::ts_to_df(x_zoo)
  expect_equal(attr(df_zoo, "scale"), "linear")

  x_ts <- ts(1:10, start = c(2020, 1), frequency = 12)
  attr(x_ts, "transform") <- "none"
  df_ts <- visdat:::ts_to_df(x_ts)
  expect_equal(attr(df_ts, "transform"), "none")
})
