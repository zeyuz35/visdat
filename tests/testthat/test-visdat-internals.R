test_vis_gather_ <- vis_gather_(typical_data)

suppressWarnings(
  test_old_gather <- typical_data %>%
    dplyr::mutate(rows = seq_len(nrow(.))) %>%
    tidyr::gather_(key_col = "variable",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)]) %>%
    dplyr::arrange(rows, variable, valueType)
)

test_that("vis_gather_ returns the same as previous",{

  expect_equal(test_vis_gather_,
               test_old_gather)

})

d_old <- typical_data %>%
  fingerprint_df() %>%
  vis_gather_()

suppressWarnings({
  d_old$value <-  tidyr::gather_(typical_data,
                                 "variables",
                                 "value", names(typical_data))$value

  d_old <- d_old %>% dplyr::arrange(value)
})

d_new <-
  typical_data %>%
  fingerprint_df() %>%
  vis_gather_() %>%
  dplyr::mutate(value = vis_extract_value_(typical_data)) %>%
  dplyr::arrange(value)
# get the values here so plotly can make them visible

test_that("vis_extract_value performs the same as old method",{
  expect_equal(d_old$value,d_new$value)
})

test_that("any_numeric returns TRUE for numeric dataframes and FALSE for dataframes containing non-numeric values",{

  expect_equal(all_numeric(airquality),TRUE)
  expect_equal(all_numeric(iris),FALSE)

})
test_that("fingerprint can deal with complete-cases list columns",{
  expect_equal(all(visdat:::fingerprint(dplyr::starwars$films)%>% is.na()),FALSE)
})

test_that("fingerprint can count n/a in list columns",{
  expect_equal(sum(visdat:::fingerprint(dplyr::starwars$vehicles)%>% is.na()),76)
})


test_that("ts_to_df preserves attributes for ts and xts objects", {
  library(tsbox)
  library(xts)

  # For ts object
  x_ts <- ts(matrix(rnorm(30), ncol=3), start=c(1990, 1), frequency=12)
  colnames(x_ts) <- c("A", "B", "C")
  attr(x_ts, "scale") <- c(1, 2, 3)
  attr(x_ts, "center") <- c(0, 0, 0)
  attr(x_ts, "user_meta") <- "keep this ts"

  df_ts <- ts_to_df(x_ts)

  expect_equal(attr(df_ts, "scale"), c(1, 2, 3))
  expect_equal(attr(df_ts, "center"), c(0, 0, 0))
  expect_equal(attr(df_ts, "user_meta"), "keep this ts")

  # For xts object
  dates <- as.Date("2020-01-01") + 0:9
  data <- matrix(rnorm(20), ncol = 2)
  x_xts <- xts::xts(data, order.by = dates)
  colnames(x_xts) <- c("A", "B")
  attr(x_xts, "scale") <- c(1, 2)
  attr(x_xts, "user_meta") <- "keep this xts"

  df_xts <- ts_to_df(x_xts)

  expect_equal(attr(df_xts, "scale"), c(1, 2))
  expect_equal(attr(df_xts, "user_meta"), "keep this xts")
})
