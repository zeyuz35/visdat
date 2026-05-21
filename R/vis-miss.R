#' Visualise a data.frame to display missingness.
#'
#' `vis_miss` provides an at-a-glance ggplot of the missingness inside a
#'   dataframe, colouring cells according to missingness, where black indicates
#'   a missing cell and grey indicates a present cell. As it returns a ggplot
#'   object, it is very easy to customize and change labels.
#'
#' The missingness summaries in the columns are rounded to the nearest integer.
#'   For more detailed summaries, please see the summaries in the `naniar` R
#'   package, specifically, `naniar::miss_var_summary()`.
#'
#' @param x a data.frame
#'
#' @param cluster logical. TRUE specifies that you want to use hierarchical
#'   clustering (mcquitty method) to arrange rows according to missingness.
#'   FALSE specifies that you want to leave it as is. Default value is FALSE.
#'
#' @param sort_miss logical. TRUE arranges the columns in order of missingness.
#'   Default value is FALSE.
#'
#' @param show_perc logical. TRUE now adds in the \% of missing/complete data
#'   in the whole dataset into the legend. Default value is TRUE.
#'
#' @param show_perc_col logical. TRUE adds in the \% missing data in a given
#'  column into the x axis. Can be disabled with FALSE. Default value is TRUE.
#'  No missingness percentage column information will be presented when `facet`
#'  argument is used. Please see the `naniar` package to provide missingness
#'  summaries over groups.
#'
#' @param warn_large_data logical - warn if there is large data? Default is TRUE
#'   see note for more details
#'
#' @param large_data_size integer default is 900000 (given by
#'   `nrow(data.frame) * ncol(data.frame)``). This can be changed. See
#'   note for more details.
#'
#' @param facet (optional) bare variable name, if you want to create a faceted
#'   plot, with one plot per level of the variable. No missingness percentage
#'   column information will be presented when `facet` argument is used. Please
#'   see the `naniar` package to provide missingness summaries over groups.
#'
#' @return `ggplot2` object displaying the position of missing values in the
#'   dataframe, and the percentage of values missing and present.
#'
#' @seealso [vis_dat()] [vis_guess()] [vis_expect()] [vis_cor()] [vis_compare()]
#'
#' @note Some datasets might be too large to plot, sometimes creating a blank
#'   plot. If this occurs, downsampling the data (e.g., by selecting the first
#'   1,000 rows or taking a random sample) is recommended. This alters the
#'   appearance of the data but prevents a blank plot. See example code for
#'   suggestions.
#'
#' @examples
#'
#' vis_miss(airquality)
#'
#' vis_miss(airquality, cluster = TRUE)
#'
#' vis_miss(airquality, sort_miss = TRUE)
#'
#' vis_miss(airquality, facet = Month)
#'
#' \dontrun{
#' # if you have a large dataset, you might want to try downsampling:
#' library(nycflights13)
#' library(dplyr)
#' flights |>
#'   dplyr::slice_sample(n = 1000) |>
#'   vis_miss()
#'
#' flights |>
#'   dplyr::slice(1:1000) |>
#'   vis_miss()
#' }
#'
#' @export
vis_miss <- function(x, ...) UseMethod("vis_miss")

#' @export
vis_miss.data.frame <- function(
  x,
  cluster = FALSE,
  sort_miss = FALSE,
  show_perc = TRUE,
  show_perc_col = TRUE,
  large_data_size = 900000,
  warn_large_data = TRUE,
  facet,
  transpose = FALSE
) {
  test_if_dataframe(x)
  test_if_large_data(x, large_data_size, warn_large_data)

  if (sort_miss) {
    col_order_index <- names(n_miss_col(x, sort = TRUE))
  } else {
    col_order_index <- names(x)
  }

  if (!missing(facet)) {
    vis_miss_data <- x |>
      dplyr::group_by({{ facet }}) |>
      data_vis_miss(cluster)

    col_order_index <- update_col_order_index(
      col_order_index,
      facet,
      environment()
    )
  } else {
    vis_miss_data <- data_vis_miss(x, cluster)
  }

  x_fingerprinted <- fingerprint_df(x)

  row_labels <- attr(x, "row_labels")

  if (show_perc) {
    temp <- miss_guide_label(x_fingerprinted)
    p_miss_lab <- temp$p_miss_lab
    p_pres_lab <- temp$p_pres_lab
  } else {
    p_miss_lab <- "Missing"
    p_pres_lab <- "Present"
  }

  ret_plot <- vis_create_(vis_miss_data) +
    ggplot2::scale_fill_manual(
      name = "",
      values = c("grey80", "grey20"),
      labels = c(p_pres_lab, p_miss_lab)
    ) +
    ggplot2::guides(fill = ggplot2::guide_legend(reverse = TRUE)) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0, vjust = 0))

  # Single-column, non-time-series: handle x-axis and return early.
  # For time series, the time branch below handles y-axis formatting.
  # Related issue: https://github.com/ropensci/visdat/issues/72
  if (ncol(x) == 1 && is.null(row_labels)) {
    ret_plot <- ret_plot +
      ggplot2::scale_y_reverse() +
      ggplot2::scale_x_discrete(
        position = "top",
        labels = if (show_perc_col) {
          label_col_missing_pct(x_fingerprinted, col_order_index)
        } else {
          col_order_index
        }
      )

    return(ret_plot)
  }

  if (!missing(facet)) {
    ret_plot <- ret_plot +
      ggplot2::facet_wrap(facets = dplyr::vars({{ facet }}))
  }

  if (!is.null(row_labels)) {
    ret_plot <- vis_add_time_geom(ret_plot, row_labels)
    ret_plot <- vis_add_time_coords(ret_plot, transpose)

    if (show_perc_col && missing(facet)) {
      ret_plot <- ret_plot +
        ggplot2::scale_x_discrete(
          position = if (transpose) "bottom" else "top",
          limits = if (transpose) rev(col_order_index) else col_order_index,
          labels = if (transpose) {
            rev(label_col_missing_pct(x_fingerprinted, col_order_index))
          } else {
            label_col_missing_pct(x_fingerprinted, col_order_index)
          }
        )
    } else {
      ret_plot <- ret_plot +
        ggplot2::scale_x_discrete(
          position = if (transpose) "bottom" else "top",
          limits = if (transpose) rev(col_order_index) else col_order_index
        )
    }
  } else {
    ret_plot <- vis_add_regular_coords(ret_plot, transpose)

    if (show_perc_col && missing(facet)) {
      ret_plot <- ret_plot +
        ggplot2::scale_x_discrete(
          position = if (transpose) "bottom" else "top",
          limits = if (transpose) rev(col_order_index) else col_order_index,
          labels = if (transpose) {
            rev(label_col_missing_pct(x_fingerprinted, col_order_index))
          } else {
            label_col_missing_pct(x_fingerprinted, col_order_index)
          }
        )
    } else {
      ret_plot <- ret_plot +
        ggplot2::scale_x_discrete(
          position = if (transpose) "bottom" else "top",
          limits = if (transpose) rev(col_order_index) else col_order_index
        )
    }
  }

  return(ret_plot)
}


# Time series methods: convert via tsbox to transposed data.frame, then dispatch.
#' @export
vis_miss.ts <- function(x, ...) {
  y <- ts_to_df(x)
  vis_miss.data.frame(y, ...)
}

#' @export
vis_miss.mts <- function(x, ...) {
  vis_miss.data.frame(ts_to_df(x), ...)
}

#' @export
vis_miss.zoo <- function(x, ...) {
  vis_miss.data.frame(ts_to_df(x), ...)
}

#' @export
vis_miss.xts <- function(x, ...) {
  vis_miss.data.frame(ts_to_df(x), ...)
}

#' @export
vis_miss.tbl_ts <- function(x, ...) {
  vis_miss.data.frame(ts_to_df(x), ...)
}

#' @export
vis_miss.tbl_df <- function(x, ...) {
  vis_miss.data.frame(as.data.frame(x), ...)
}

#' @export
vis_miss.tsibble <- function(x, ...) {
  vis_miss.data.frame(ts_to_df(x), ...)
}

#' @export
vis_miss.default <- function(x, ...) {
  if (tsbox::ts_boxable(x)) {
    vis_miss.data.frame(ts_to_df(x), ...)
  } else {
    stop(
      "vis_miss requires a data.frame or supported time series object",
      call. = FALSE
    )
  }
}
