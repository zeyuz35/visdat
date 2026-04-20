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


test_that("ts_to_df preserves non-structural attributes", {
  skip_if_not_installed("tsbox")
  skip_if_not_installed("xts")
  skip_if_not_installed("zoo")

  # Test with ts object
  x_ts <- ts(1:10)
  attr(x_ts, "scale") <- 2.5
  attr(x_ts, "transform") <- "log"

  x_ts_df <- ts_to_df(x_ts)
  expect_equal(attr(x_ts_df, "scale"), 2.5)
  expect_equal(attr(x_ts_df, "transform"), "log")

  # Test with xts object
  x_xts <- xts::xts(1:10, order.by = Sys.Date() + 1:10)
  attr(x_xts, "custom_meta") <- "meta_value"

  x_xts_df <- ts_to_df(x_xts)
  expect_equal(attr(x_xts_df, "custom_meta"), "meta_value")

  # Test with mts object
  x_mts <- ts(matrix(1:20, ncol = 2))
  attr(x_mts, "mts_attr") <- TRUE

  x_mts_df <- ts_to_df(x_mts)
  expect_equal(attr(x_mts_df, "mts_attr"), TRUE)
})
