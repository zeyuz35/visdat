library(testthat)

ts_to_df <- function(x) {
  if (!tsbox::ts_boxable(x)) {
    cli::cli_abort(
      "This vis_ function requires a data.frame or supported time series object"
    )
  }

  original_attrs <- attributes(x)

  x_df <- tsbox::ts_df(x)
  if ("id" %in% names(x_df)) {
    x_df <- tsbox::ts_wide(x_df)
  }

  # pick a time-like index column from ts_df output
  time_cols <- names(x_df)[vapply(
    x_df,
    function(col) {
      inherits(
        col,
        c(
          "Date",
          "POSIXct",
          "POSIXt",
          "yearquarter",
          "yearmonth",
          "yearweek",
          "yearmonth",
          "yearquarter",
          "ts"
        )
      )
    },
    logical(1)
  )]

  if (length(time_cols) == 0L) {
    cli::cli_abort("Could not detect a time index column in ts_df output")
  }

  time_idx <- x_df[[time_cols[1]]]

  data_cols <- setdiff(names(x_df), time_cols[1])
  if (length(data_cols) == 0L) {
    cli::cli_abort("Time series object must contain at least one data column")
  }

  series_df <- x_df[data_cols]

  if (nrow(series_df) != length(time_idx)) {
    cli::cli_abort("Unexpected mismatch between time index and series rows")
  }

  # store time index as row labels for plotting x axis
  attr(series_df, "row_labels") <- time_idx

  structural_attrs <- c("dim", "dimnames", "tsp", "class", "names", "row.names", "index", "indexClass", "tclass", "tzone")
  attrs_to_restore <- original_attrs[setdiff(names(original_attrs), structural_attrs)]
  if (length(attrs_to_restore) > 0) {
    attributes(series_df) <- utils::modifyList(attributes(series_df), attrs_to_restore)
  }

  series_df
}

# Setup dummy data with attributes
mat <- matrix(rnorm(12), ncol=2)
x_ts <- ts(mat, start=c(2000, 1), frequency=12)
attr(x_ts, "scale") <- 2.0
attr(x_ts, "transform") <- "log"

out <- tryCatch(ts_to_df(x_ts), error=function(e) NULL)
