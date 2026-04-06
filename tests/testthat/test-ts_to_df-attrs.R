context("ts_to_df attribute preservation")

test_that("ts_to_df preserves custom attributes across time-series classes", {
  # 1. ts
  x_ts <- ts(rnorm(10), start = c(2000, 1), frequency = 12)
  attr(x_ts, "scale") <- "log"
  attr(x_ts, "transform") <- "diff"

  df_ts <- visdat:::ts_to_df(x_ts)
  expect_equal(attr(df_ts, "scale"), "log")
  expect_equal(attr(df_ts, "transform"), "diff")
  expect_s3_class(df_ts, "data.frame")

  # 2. zoo
  skip_if_not_installed("zoo")
  x_zoo <- zoo::zoo(rnorm(10), order.by = as.Date("2000-01-01") + 0:9)
  attr(x_zoo, "scale") <- "linear"

  df_zoo <- visdat:::ts_to_df(x_zoo)
  expect_equal(attr(df_zoo, "scale"), "linear")
  expect_s3_class(df_zoo, "data.frame")

  # 3. xts
  skip_if_not_installed("xts")
  x_xts <- xts::xts(rnorm(10), order.by = as.Date("2000-01-01") + 0:9)
  attr(x_xts, "my_custom_attr") <- 42

  df_xts <- visdat:::ts_to_df(x_xts)
  expect_equal(attr(df_xts, "my_custom_attr"), 42)
  expect_s3_class(df_xts, "data.frame")

  # 4. mts
  x_mts <- ts(matrix(rnorm(20), ncol=2), start = c(2000, 1), frequency = 12)
  attr(x_mts, "custom_mts") <- "hello"

  df_mts <- visdat:::ts_to_df(x_mts)
  expect_equal(attr(df_mts, "custom_mts"), "hello")
  expect_s3_class(df_mts, "data.frame")
})

test_that("ts_to_df fails with clear error for NULL or invalid inputs", {
  expect_error(visdat:::ts_to_df(NULL))
  expect_error(visdat:::ts_to_df(list(a = 1)), "requires a data.frame or supported time series object")
})
