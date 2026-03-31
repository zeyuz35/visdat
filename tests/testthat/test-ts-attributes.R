test_that("ts_to_df preserves custom attributes", {
  mat <- matrix(rnorm(12), ncol=2)
  x_ts <- ts(mat, start=c(2000, 1), frequency=12)
  attr(x_ts, "scale") <- 2.0
  attr(x_ts, "transform") <- "log"

  out <- ts_to_df(x_ts)

  expect_equal(attr(out, "scale"), 2.0)
  expect_equal(attr(out, "transform"), "log")
  expect_s3_class(out, "data.frame")
})
