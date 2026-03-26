test_that("ts_to_df preserves attributes for ts objects", {
  my_ts <- ts(1:10, start = c(2000, 1), frequency = 4)
  attr(my_ts, "scale") <- "log"
  attr(my_ts, "transform") <- "diff"
  df <- ts_to_df(my_ts)
  expect_equal(attributes(df)$scale, "log")
  expect_equal(attributes(df)$transform, "diff")
})
test_that("ts_to_df preserves attributes for xts objects", {
  my_xts <- xts::xts(1:10, order.by = as.Date("2000-01-01") + 0:9)
  attr(my_xts, "scale") <- "log"
  attr(my_xts, "transform") <- "diff"
  df <- ts_to_df(my_xts)
  expect_equal(attributes(df)$scale, "log")
  expect_equal(attributes(df)$transform, "diff")
})
test_that("ts_to_df preserves attributes for zoo objects", {
  my_zoo <- zoo::zoo(1:10, order.by = as.Date("2000-01-01") + 0:9)
  attr(my_zoo, "scale") <- "log"
  attr(my_zoo, "transform") <- "diff"
  df <- ts_to_df(my_zoo)
  expect_equal(attributes(df)$scale, "log")
  expect_equal(attributes(df)$transform, "diff")
})