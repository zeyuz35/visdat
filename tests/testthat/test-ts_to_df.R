library(testthat)

test_that("ts_to_df preserves custom attributes and handles structural attributes correctly", {
  skip_if_not_installed("tsbox")

  # Create a basic time-series object
  x <- ts(1:10, start = c(2000, 1), frequency = 4)

  # Attach custom attributes
  attr(x, "scale") <- 2.5
  attr(x, "transform") <- "log"
  attr(x, "user_metadata") <- list(author = "Curator", date = "2024-03-31")

  # Use ts_to_df via triple colon since it's an internal function
  df <- visdat:::ts_to_df(x)

  # 1. Output class should be a plain data.frame
  expect_true(inherits(df, "data.frame"))
  expect_false(inherits(df, "ts"))

  # 2. Time index should be stored in 'row_labels'
  expect_true(!is.null(attr(df, "row_labels")))
  expect_equal(length(attr(df, "row_labels")), 10)

  # 3. Custom attributes should be preserved
  expect_equal(attr(df, "scale"), 2.5)
  expect_equal(attr(df, "transform"), "log")
  expect_equal(attr(df, "user_metadata")$author, "Curator")

  # 4. Structural attributes specific to 'ts' should be filtered out
  # (e.g. tsp is specific to ts, shouldn't be on the returned data.frame)
  expect_null(attr(df, "tsp"))
})

test_that("ts_to_df preserves attributes from xts objects", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("xts")
  skip_if_not_installed("zoo")

  dates <- seq(as.Date("2020-01-01"), length = 5, by = "days")
  x_xts <- xts::xts(rnorm(5), order.by = dates)

  attr(x_xts, "my_custom_tag") <- "keep_me"

  df <- visdat:::ts_to_df(x_xts)

  expect_true(inherits(df, "data.frame"))
  expect_equal(attr(df, "my_custom_tag"), "keep_me")

  # structural attributes of xts shouldn't pollute the data.frame
  expect_null(attr(df, "indexClass"))
  expect_null(attr(df, "tclass"))
  expect_null(attr(df, "tzone"))
  expect_null(attr(df, "index"))
})
