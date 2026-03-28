dat_test <- tibble::tribble(
  ~x, ~y,
  -1, "A",
  0, "B",
  1, "C",
  NA, NA
)


# try out all the options
vis_expect_plot <- vis_expect(dat_test, ~ .x == -1)
vis_expect_plot_show_perc_true <- vis_expect(dat_test,
  ~ .x == -1,
  show_perc = FALSE
)

test_that("vis_expect creates the right plot", {
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger(
    "vis_expect vanilla",
    vis_expect_plot
  )
  vdiffr::expect_doppelganger(
    "vis_expect show perc true",
    vis_expect_plot_show_perc_true
  )
})

test_that("vis_expect accepts ts objects via S3 dispatch", {
  # AirPassengers dispatches via vis_expect.ts
  p <- vis_expect(AirPassengers, ~ .x < 400)
  expect_s3_class(p, "ggplot")
})
