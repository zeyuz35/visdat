test_that("vis_miss handles transpose correctly on data.frame", {
  p_df <- vis_miss(mtcars, transpose = TRUE)
  expect_s3_class(p_df, "ggplot")
  
  b_df <- ggplot2::ggplot_build(p_df)
  expect_true(inherits(b_df, "ggplot_built"))
})

test_that("vis_miss handles transpose correctly on time series", {
  skip_if_not_installed("vars")
  canada_miss <- vars::Canada
  canada_miss[1,1] <- NA
  p_ts <- vis_miss(canada_miss, transpose = TRUE)
  expect_s3_class(p_ts, "ggplot")
  
  b_ts <- ggplot2::ggplot_build(p_ts)
  expect_true(inherits(b_ts, "ggplot_built"))
})

test_that("time-series coordinate flipping logic works", {
  p <- ggplot2::ggplot(data.frame(x=1, y=as.Date(c('2020-01-01', '2020-02-01'))), ggplot2::aes(x, y)) + 
       ggplot2::geom_tile() + 
       ggplot2::scale_y_date(expand=c(0,0)) + 
       ggplot2::coord_flip()
  
  expect_s3_class(p, "ggplot")
  expect_true(inherits(ggplot2::ggplot_build(p), "ggplot_built"))
})
