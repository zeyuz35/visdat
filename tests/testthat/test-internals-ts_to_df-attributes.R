test_that("ts_to_df preserves non-structural attributes", {
  skip_if_not_installed("tsbox")

  my_ts <- ts(1:10)
  attr(my_ts, "scale") <- 10
  attr(my_ts, "transform") <- "log"

  res <- ts_to_df(my_ts)
  expect_equal(attr(res, "scale"), 10)
  expect_equal(attr(res, "transform"), "log")
})
