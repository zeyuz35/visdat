test_that("ts_to_df preserves original attributes", {
  skip_if_not_installed("xts")
  skip_if_not_installed("zoo")
  skip_if_not_installed("tsbox")

  library(xts)

  dates <- seq(as.Date("2020-01-01"), length = 5, by = "days")
  x_xts <- xts(matrix(1:10, ncol = 2), order.by = dates)
  colnames(x_xts) <- c("A", "B")
  attr(x_xts, "scale") <- "log"
  attr(x_xts, "transform") <- "diff"

  df <- visdat:::ts_to_df(x_xts)

  expect_equal(attr(df, "scale"), "log")
  expect_equal(attr(df, "transform"), "diff")
})
