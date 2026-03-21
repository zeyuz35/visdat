# make a new dataset of iris that contains some NA values

iris_diff <- iris
iris_diff[1:10, 1:2] <- NA

vis_compare_plot <- vis_compare(iris, iris_diff)

test_that("vis_compare works",{
  skip_on_cran()
  skip_on_ci()
vdiffr::expect_doppelganger("vis_compare vanilla", vis_compare_plot)
})

iris_add <- iris
iris_add$extra <- 1

test_that("vis_compare will not accept two dataframes of differing dims",{
  expect_snapshot(
    error = TRUE,
    vis_compare(iris, iris_add)
    )
})

test_that("vis_compare accepts ts objects via S3 dispatch", {
  skip_if_not_installed("vars")
  canada_diff <- vars::Canada
  canada_diff[1:5, 1:2] <- NA
  p <- vis_compare(vars::Canada, canada_diff)
  expect_s3_class(p, "ggplot")
})

test_that("vis_compare fails when one arg is not a ts-boxable object", {
  expect_error(
    vis_compare(iris, AirPassengers),
    regexp = NULL
  )
})

