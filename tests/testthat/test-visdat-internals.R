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


test_that("ts_to_df preserves custom attributes while avoiding structural conflicts", {
  skip_if_not_installed("tsbox")

  # test with ts
  x_ts <- ts(1:10, start = 2000, frequency = 1)
  attr(x_ts, "scale") <- "log"
  attr(x_ts, "custom_meta") <- 123

  df_ts <- ts_to_df(x_ts)

  expect_equal(attr(df_ts, "scale"), "log")
  expect_equal(attr(df_ts, "custom_meta"), 123)
  expect_s3_class(df_ts, "data.frame")
  expect_false("tsp" %in% names(attributes(df_ts)))

  # test with zoo
  skip_if_not_installed("zoo")
  x_zoo <- zoo::zoo(1:10, order.by = seq(as.Date("2000-01-01"), by = "days", length.out = 10))
  attr(x_zoo, "scale") <- "log"
  attr(x_zoo, "custom_meta") <- 123

  df_zoo <- ts_to_df(x_zoo)

  expect_equal(attr(df_zoo, "scale"), "log")
  expect_equal(attr(df_zoo, "custom_meta"), 123)
  expect_s3_class(df_zoo, "data.frame")
  expect_false("index" %in% names(attributes(df_zoo)))

  # test with xts
  skip_if_not_installed("xts")
  x_xts <- xts::xts(1:10, order.by = seq(as.Date("2000-01-01"), by = "days", length.out = 10))
  attr(x_xts, "scale") <- "log"
  attr(x_xts, "custom_meta") <- 123

  df_xts <- ts_to_df(x_xts)

  expect_equal(attr(df_xts, "scale"), "log")
  expect_equal(attr(df_xts, "custom_meta"), 123)
  expect_s3_class(df_xts, "data.frame")
  expect_false("indexClass" %in% names(attributes(df_xts)))
})
