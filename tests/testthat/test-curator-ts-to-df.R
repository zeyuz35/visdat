test_that("ts_to_df gracefully handles ts with multiple names", {
  test_ts <- ts(1:10, start = c(2000, 1), frequency = 12)
  names(test_ts) <- letters[1:10] # Multiple names

  res <- ts_to_df(test_ts)
  expect_equal(names(res), "value")
  expect_s3_class(res, "data.frame")
})
