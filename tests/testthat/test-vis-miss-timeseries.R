# Test vis_miss time series functionality
# Verifies that time series plots have correctly ordered y-axes

test_that("vis_miss time series y-axis is ordered oldest to newest", {

  library(vars)
  library(tsibble)

  # Helper to get y-axis range from built plot
  get_y_range <- function(p) {
    built <- ggplot2::ggplot_build(p)
    built$layout$panel_params[[1]]$y.range
  }

  # 1) ts object (single column) - simplest case
  canada_single <- Canada[, 1, drop = FALSE]
  canada_single[1] <- NA

  p_ts <- vis_miss(canada_single)
  y_range_ts <- get_y_range(p_ts)

  # Y-axis range: because time is negated in vis_add_time_geom,
  # y_range[2] > y_range[1] means oldest at top, newest at bottom
  # (negated: older dates become more negative, appear at visual top)
  expect_true(y_range_ts[2] > y_range_ts[1],
    info = "Y-axis top (older) should be greater than bottom (newer)"
  )

  # 2) tsibble object
  simple_ts <- tsibble(
    Quarter = yearquarter("2010 Q1") + 0:11,
    Trips = rnorm(12),
    index = Quarter
  )
  simple_ts[2, 2] <- NA

  p_tbl <- vis_miss(simple_ts)
  y_range_tbl <- get_y_range(p_tbl)

  expect_true(y_range_tbl[2] > y_range_tbl[1],
    info = "tsibble y-axis should have older at top, newer at bottom"
  )

  # 3) mts object (multiple columns)
  canada_miss <- Canada
  canada_miss[1, 1] <- NA
  canada_miss[5, 2] <- NA

  p_mts <- vis_miss(canada_miss)
  y_range_mts <- get_y_range(p_mts)

  expect_true(y_range_mts[2] > y_range_mts[1],
    info = "mts y-axis should have older at top, newer at bottom"
  )
})

test_that("vis_miss returns ggplot object for time series", {
  library(vars)
  library(tsibble)

  canada_miss <- Canada
  canada_miss[1, 1] <- NA

  # mts
  p_mts <- vis_miss(canada_miss)
  expect_s3_class(p_mts, "ggplot")

  # ts
  p_ts <- vis_miss(canada_miss[, 1])
  expect_s3_class(p_ts, "ggplot")

  # tsibble
  simple_ts <- tsibble(
    Quarter = yearquarter("2010 Q1") + 0:11,
    Trips = rnorm(12),
    index = Quarter
  )
  p_tbl <- vis_miss(simple_ts)
  expect_s3_class(p_tbl, "ggplot")
})

test_that("vis_miss time series with transpose = TRUE has Time on x-axis", {
  library(vars)
  library(tsibble)

  canada_single <- Canada[, 1, drop = FALSE]
  canada_single[1] <- NA

  canada_miss <- Canada
  canada_miss[1, 1] <- NA
  canada_miss[5, 2] <- NA

  simple_ts <- tsibble(
    Quarter = yearquarter("2010 Q1") + 0:11,
    Trips = rnorm(12),
    index = Quarter
  )
  simple_ts[2, 2] <- NA

  # ts with transpose
  p_ts_t <- vis_miss(canada_single, transpose = TRUE)
  expect_equal(p_ts_t$labels$x, "Time",
    info = "ts transposed x-axis label should be 'Time'")
  expect_equal(p_ts_t$labels$y, "",
    info = "ts transposed y-axis label should be empty")

  # mts with transpose
  p_mts_t <- vis_miss(canada_miss, transpose = TRUE)
  expect_equal(p_mts_t$labels$x, "Time",
    info = "mts transposed x-axis label should be 'Time'")

  # tsibble with transpose
  p_tbl_t <- vis_miss(simple_ts, transpose = TRUE)
  expect_equal(p_tbl_t$labels$x, "Time",
    info = "tsibble transposed x-axis label should be 'Time'")
})
