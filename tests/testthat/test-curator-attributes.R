context("Curator: attribute preservation for time series inputs")

test_that("custom attributes are preserved when converting time series with ts_to_df", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("xts")
  skip_if_not_installed("zoo")

  # Create data
  dates <- seq(as.Date("2020-01-01"), length = 10, by = "days")
  mat <- matrix(rnorm(20), ncol=2)

  # 1. xts
  ts_xts <- xts::xts(mat, order.by = dates)
  attributes(ts_xts)$my_scale <- 2.5
  attributes(ts_xts)$my_transform <- "log"

  out_xts <- ts_to_df(ts_xts)
  expect_equal(attr(out_xts, "my_scale"), 2.5)
  expect_equal(attr(out_xts, "my_transform"), "log")
  expect_s3_class(out_xts, "data.frame")
  expect_null(attr(out_xts, "index"))

  # 2. zoo
  ts_zoo <- zoo::zoo(mat, order.by = dates)
  attributes(ts_zoo)$my_scale <- 2.5
  attributes(ts_zoo)$my_transform <- "log"

  out_zoo <- ts_to_df(ts_zoo)
  expect_equal(attr(out_zoo, "my_scale"), 2.5)
  expect_equal(attr(out_zoo, "my_transform"), "log")
  expect_s3_class(out_zoo, "data.frame")
  expect_null(attr(out_zoo, "index"))

  # 3. ts
  ts_ts <- stats::ts(mat, start = c(2020, 1), frequency = 12)
  attributes(ts_ts)$my_scale <- 2.5
  attributes(ts_ts)$my_transform <- "log"

  out_ts <- ts_to_df(ts_ts)
  expect_equal(attr(out_ts, "my_scale"), 2.5)
  expect_equal(attr(out_ts, "my_transform"), "log")
  expect_s3_class(out_ts, "data.frame")
  expect_null(attr(out_ts, "tsp"))

  # 4. mts
  ts_mts <- stats::ts(mat, start = c(2020, 1), frequency = 12)
  class(ts_mts) <- c("mts", "ts", "matrix", "array")
  attributes(ts_mts)$my_scale <- 2.5
  attributes(ts_mts)$my_transform <- "log"

  out_mts <- ts_to_df(ts_mts)
  expect_equal(attr(out_mts, "my_scale"), 2.5)
  expect_equal(attr(out_mts, "my_transform"), "log")
  expect_s3_class(out_mts, "data.frame")
  expect_null(attr(out_mts, "tsp"))

})
