library(tsbox)
library(zoo)

source("R/internals.R")

ts_to_df_patched <- function(x) {
  if (!tsbox::ts_boxable(x)) {
    cli::cli_abort(
      "This vis_ function requires a data.frame or supported time series object"
    )
  }

  # Capture original attributes
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

  # Restore attributes, excluding structural ones
  attrs_to_restore <- original_attrs[setdiff(names(original_attrs),
                                         c("dim", "dimnames", "tsp", "class", "names", "row.names", "index"))]
  if (length(attrs_to_restore) > 0) {
    attributes(series_df) <- c(attributes(series_df), attrs_to_restore)
  }

  series_df
}

# Create mock data
x <- zoo(1:10, as.Date("2000-01-01") + 0:9)
attr(x, "scale") <- 2
attr(x, "transform") <- "log"

cat("\n--- Testing ts_to_df_patched ---\n")
y <- ts_to_df_patched(x)
print(str(y))
