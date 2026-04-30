test_that("ts_to_df preserves custom attributes and handles length > 1 names", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("zoo")
  skip_if_not_installed("xts")

  # test ts
  x_ts <- ts(1:10)
  attr(x_ts, "scale") <- 2.5
  attr(x_ts, "transform") <- "log"
  names(x_ts) <- c("a", "b", "c") # length > 1 names

  df_ts <- ts_to_df(x_ts)
  expect_equal(attr(df_ts, "scale"), 2.5)
  expect_equal(attr(df_ts, "transform"), "log")
  expect_equal(names(df_ts), "value") # Did not use names due to length > 1

  # test zoo
  x_zoo <- zoo::zoo(1:10, order.by = as.Date("2020-01-01") + 0:9)
  attr(x_zoo, "scale") <- 3.0
  df_zoo <- ts_to_df(x_zoo)
  expect_equal(attr(df_zoo, "scale"), 3.0)

  # test xts
  x_xts <- xts::xts(1:10, order.by = as.Date("2020-01-01") + 0:9)
  attr(x_xts, "transform") <- "diff"
  df_xts <- ts_to_df(x_xts)
  expect_equal(attr(df_xts, "transform"), "diff")
})
