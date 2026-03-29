# try out all the options
vis_dat_plot <- vis_dat(typical_data)
vis_dat_plot_sort_type <- vis_dat(typical_data, sort_type = FALSE)
vis_dat_plot_pal_qual <- vis_dat(typical_data, palette = "qual")
vis_dat_plot_pal_cb <- vis_dat(typical_data, palette = "cb_safe")

test_that("vis_dat creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_dat vanilla",
                              vis_dat_plot)
  vdiffr::expect_doppelganger("vis_dat sort_type",
                              vis_dat_plot_sort_type)
  vdiffr::expect_doppelganger("vis_dat qualitative palette",
                              vis_dat_plot_pal_qual)
  vdiffr::expect_doppelganger("vis_dat colourblind safe palette",
                              vis_dat_plot_pal_cb)
})

test_that("vis_dat doesn't fail when using diamonds",{
  expect_s3_class(vis_dat(ggplot2::diamonds), "gg")
})

test_that("vis_dat fails when the wrong palette is provided",{
  expect_snapshot(
    error = TRUE,
    vis_dat(typical_data, palette = "wat")
    )
})

test_that("vis_dat accepts ts objects via S3 dispatch", {
  # AirPassengers now dispatches via vis_dat.ts, so it should succeed
  p <- vis_dat(AirPassengers)
  expect_s3_class(p, "ggplot")
})

vis_dat_facet <- vis_dat(airquality, facet = Month)

test_that("vis_dat works with facetting", {
  skip_on_ci()
  skip_on_cran()
  vdiffr::expect_doppelganger("vis_dat_facet", vis_dat_facet)
})

library(dplyr)
the_vis_dat_data <- data_vis_dat(airquality)
the_vis_dat_data_month <- airquality %>% group_by(Month) %>% data_vis_dat()

test_that("data_vis_dat gets the data properly", {
  expect_type(the_vis_dat_data, "list")
  expect_s3_class(the_vis_dat_data, "data.frame")
  expect_snapshot(the_vis_dat_data)
})

test_that("data_vis_dat gets the data properly for groups", {
  expect_type(the_vis_dat_data_month, "list")
  expect_s3_class(the_vis_dat_data_month, "data.frame")
  expect_snapshot(the_vis_dat_data_month)
})

test_that("ts_to_df preserves custom attributes", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("xts")
  skip_if_not_installed("zoo")

  mat <- matrix(1:10, ncol=2)
  x <- xts::xts(mat, order.by = as.Date("2020-01-01") + 0:4)
  attr(x, "scale") <- "foo"
  attr(x, "transform") <- "bar"
  res_x <- ts_to_df(x)
  expect_equal(attr(res_x, "scale"), "foo")
  expect_equal(attr(res_x, "transform"), "bar")

  z <- zoo::zoo(mat, order.by = as.Date("2020-01-01") + 0:4)
  attr(z, "scale") <- "zoo_scale"
  res_z <- ts_to_df(z)
  expect_equal(attr(res_z, "scale"), "zoo_scale")

  y <- ts(mat, start = c(2020, 1), frequency = 12)
  attr(y, "ts_scale") <- "baz"
  res_y <- ts_to_df(y)
  expect_equal(attr(res_y, "ts_scale"), "baz")
})
