test_that("ts_to_df preserves custom attributes", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("zoo")
  skip_if_not_installed("xts")

  # ts
  x_ts <- ts(1:10, start = c(2000, 1), frequency = 12)
  attr(x_ts, "scale") <- "log"
  df_ts <- visdat:::ts_to_df(x_ts)
  expect_equal(attr(df_ts, "scale"), "log")

  # zoo
  x_zoo <- zoo::zoo(1:10, order.by = as.Date("2000-01-01") + 0:9)
  attr(x_zoo, "scale") <- "log"
  df_zoo <- visdat:::ts_to_df(x_zoo)
  expect_equal(attr(df_zoo, "scale"), "log")

  # xts
  x_xts <- xts::xts(1:10, order.by = as.Date("2000-01-01") + 0:9)
  attr(x_xts, "scale") <- "log"
  df_xts <- visdat:::ts_to_df(x_xts)
  expect_equal(attr(df_xts, "scale"), "log")

  # mts
  x_mts <- ts(matrix(1:20, ncol = 2), start = c(2000, 1), frequency = 12)
  attr(x_mts, "scale") <- "log"
  df_mts <- visdat:::ts_to_df(x_mts)
  expect_equal(attr(df_mts, "scale"), "log")
})
