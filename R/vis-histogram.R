#' Visualise histogram of numeric columns in a data.frame
#'
#' `vis_histogram` visualises the distribution of every numeric column in a
#'   dataframe and displays it using a faceted ggplot object.
#'
#' @param x a data.frame
#' @param ... Other arguments are passed as geom_histogram arguments.
#'
#' @return `ggplot2` object displaying the guess of the type of values in the
#'   data frame and the position of any missing values.
#'
#' @examples
#'
#' vis_histogram(airquality, bins = 30)
#'
#' @export
vis_histogram <- function(x, ...) UseMethod("vis_histogram")

#' @rdname vis-histogram
#' @export
vis_histogram.data.frame <- function(x, ...) {
  test_if_dataframe(x)
  test_if_all_numeric(x)

  vis_histogram_plot <- vis_histogram_create(x, ...)

  vis_histogram_plot
}

#' @rdname vis-histogram
#' @export
vis_histogram.ts <- function(x, ...) {
  y <- ts_to_df(x)
  vis_histogram.data.frame(y, ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.mts <- function(x, ...) {
  y <- ts_to_df(x)
  vis_histogram.data.frame(y, ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.zoo <- function(x, ...) {
  y <- ts_to_df(x)
  vis_histogram.data.frame(y, ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.xts <- function(x, ...) {
  y <- ts_to_df(x)
  vis_histogram.data.frame(y, ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.tbl_ts <- function(x, ...) {
  y <- ts_to_df(x)
  vis_histogram.data.frame(y, ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.tbl_df <- function(x, ...) {
  vis_histogram.data.frame(as.data.frame(x), ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.tsibble <- function(x, ...) {
  y <- ts_to_df(x)
  vis_histogram.data.frame(y, ...)
}

#' @rdname vis-histogram
#' @export
vis_histogram.default <- function(x, ...) {
  if (tsbox::ts_boxable(x)) {
    y <- ts_to_df(x)
    vis_histogram.data.frame(y, ...)
  } else {
    stop(
      "vis_histogram requires a data.frame or supported time series object",
      call. = FALSE
    )
  }
}

vis_histogram_create <- function(data, ...) {
  data |>
    dplyr::mutate(rows = dplyr::row_number()) |>
    tidyr::pivot_longer(cols = -rows) |>
    dplyr::filter(!is.na(value)) |>
    ggplot2::ggplot(ggplot2::aes(value)) +
    ggplot2::facet_wrap(~ name, scales = "free") +
    ggplot2::geom_histogram(...) +
    ggplot2::theme_minimal() +
    ggplot2::labs(x = "", y = "") +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Histogram")) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 0.1)
    )
}
