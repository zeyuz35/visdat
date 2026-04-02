test_that("ts_to_df preserves custom attributes for ts", {
  skip_if_not_installed("tsbox")
  x <- ts(matrix(1:10, ncol=2), start = 1990)
  attr(x, "scale") <- 2
  attr(x, "transform") <- "log"

  df <- ts_to_df(x)
  expect_equal(attr(df, "scale"), 2)
  expect_equal(attr(df, "transform"), "log")
})

test_that("ts_to_df preserves custom attributes for xts", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("xts")
  x <- xts::xts(matrix(1:10, ncol=2), order.by = as.Date("1990-01-01") + 0:4)
  attr(x, "scale") <- 3

  df <- ts_to_df(x)
  expect_equal(attr(df, "scale"), 3)
})
