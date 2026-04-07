library(testthat)

test_that("ts_to_df preserves custom attributes and outputs data.frame", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("zoo")
  skip_if_not_installed("xts")

  # numeric test
  expect_error(visdat:::ts_to_df(1:10)) # It needs ts_boxable

  # ts object
  x_ts <- ts(1:10, start=c(2020,1), frequency=12)
  attr(x_ts, "scale") <- "log"
  attr(x_ts, "transform") <- "diff"

  df_ts <- visdat:::ts_to_df(x_ts)
  expect_s3_class(df_ts, "data.frame")
  expect_equal(attr(df_ts, "scale"), "log")
  expect_equal(attr(df_ts, "transform"), "diff")

  # mts object
  x_mts <- ts(matrix(1:20, ncol=2), start=c(2020,1), frequency=12)
  colnames(x_mts) <- c("A", "B")
  attr(x_mts, "scale") <- "log"
  attr(x_mts, "transform") <- "diff"

  df_mts <- visdat:::ts_to_df(x_mts)
  expect_s3_class(df_mts, "data.frame")
  expect_equal(names(df_mts), c("A", "B"))
  expect_equal(attr(df_mts, "scale"), "log")
  expect_equal(attr(df_mts, "transform"), "diff")

  # zoo object
  x_zoo <- zoo::zoo(1:10, order.by = as.Date("2020-01-01") + 0:9)
  attr(x_zoo, "scale") <- "log"
  attr(x_zoo, "transform") <- "diff"

  df_zoo <- visdat:::ts_to_df(x_zoo)
  expect_s3_class(df_zoo, "data.frame")
  expect_equal(attr(df_zoo, "scale"), "log")
  expect_equal(attr(df_zoo, "transform"), "diff")

  # xts object
  x_xts <- xts::xts(1:10, order.by = as.Date("2020-01-01") + 0:9)
  colnames(x_xts) <- "A"
  attr(x_xts, "scale") <- "log"
  attr(x_xts, "transform") <- "diff"

  df_xts <- visdat:::ts_to_df(x_xts)
  expect_s3_class(df_xts, "data.frame")
  expect_equal(names(df_xts), "A")
  expect_equal(attr(df_xts, "scale"), "log")
  expect_equal(attr(df_xts, "transform"), "diff")
})
