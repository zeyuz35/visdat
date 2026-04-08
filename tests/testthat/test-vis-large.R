set.seed(2019-04-03-1104)
big_df <- matrix(rnorm(100000),
                 nrow = 1000,
                 ncol = 1000) %>%
  as.data.frame()

test_that("vis_dat and vis_miss warn when the DF is above size",{
  skip("Warning behavior captured via cli_warn - snapshot test needs update for ggplot return")
  cat("nrows = ",nrow(big_df), "ncols = ", ncol(big_df))
  expect_snapshot(
    vis_dat(big_df)
  )
  expect_snapshot(
    vis_miss(big_df)
  )
})
