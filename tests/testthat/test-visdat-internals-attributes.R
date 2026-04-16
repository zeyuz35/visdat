
test_that("ts_to_df preserves custom attributes for ts, xts, and zoo", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("zoo")
  skip_if_not_installed("xts")

  library(zoo)
  library(xts)

  # Test ts
  x_ts <- ts(1:10, start = c(2000, 1), frequency = 12)
  attr(x_ts, "scale") <- 10
  attr(x_ts, "transform") <- "log"
  res_ts <- ts_to_df(x_ts)
  expect_equal(attr(res_ts, "scale"), 10)
  expect_equal(attr(res_ts, "transform"), "log")
  expect_s3_class(res_ts, "data.frame")

  # Test zoo
  x_zoo <- zoo(1:10, order.by = as.Date("2000-01-01") + 0:9)
  attr(x_zoo, "scale") <- 20
  attr(x_zoo, "transform") <- "sqrt"
  res_zoo <- ts_to_df(x_zoo)
  expect_equal(attr(res_zoo, "scale"), 20)
  expect_equal(attr(res_zoo, "transform"), "sqrt")
  expect_s3_class(res_zoo, "data.frame")

  # Test xts
  x_xts <- xts(1:10, order.by = as.Date("2000-01-01") + 0:9)
  attr(x_xts, "scale") <- 30
  attr(x_xts, "transform") <- "diff"
  res_xts <- ts_to_df(x_xts)
  expect_equal(attr(res_xts, "scale"), 30)
  expect_equal(attr(res_xts, "transform"), "diff")
  expect_s3_class(res_xts, "data.frame")
})
