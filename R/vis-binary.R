#' Visualise binary values
#'
#'
#' @param data a data.frame
#' @param col_zero colour for zeroes, default is "salmon"
#' @param col_one colour for ones, default is "steelblue2"
#' @param col_na colour for NA, default is "grey90"
#' @param order optional character vector of the order of variables
#'
#' @return a ggplot plot of the binary values
#'
#' @examples
#' vis_binary(dat_bin)
#'
#' # changing order of variables
#' # create numeric names
#' df <-  setNames(dat_bin, c("1.1", "8.9", "10.4"))
#' df
#'
#' # not ideal
#' vis_binary(df)
#' # good - specify the original order
#' vis_binary(df, order = names(df))
#' @export
vis_binary <- function(data, ...) UseMethod("vis_binary")

#' @export
vis_binary.data.frame <- function(data,
                                  col_zero = "salmon",
                                  col_one = "steelblue2",
                                  col_na = "grey90",
                                  order = NULL,
                                  transpose = FALSE, ...) {

  test_if_all_binary(data)

  vis_data <- data |>
    vis_gather_() |>
    dplyr::mutate(value = vis_extract_value_(data)) |>
    dplyr::mutate(valueType = factor(valueType, levels = unique(stats::na.omit(valueType))),
                  value = factor(value, levels = unique(stats::na.omit(value))),
                  variable = if (is.null(order)) variable else factor(variable, levels = unique(c(order, levels(factor(variable))))))

  ret_plot <- vis_create_(vis_data) +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    ggplot2::scale_fill_manual(values = c(col_zero, col_one),
                               na.value = col_na)

  row_labels <- attr(data, "row_labels")

  if (!is.null(row_labels)) {
    ret_plot <- vis_add_time_geom(ret_plot, row_labels)
    ret_plot <- ret_plot +
      ggplot2::scale_x_discrete(
        position = if (transpose) "bottom" else "top",
        limits = if (transpose) rev(names(data)) else names(data)
      ) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))
    ret_plot <- vis_add_time_coords(ret_plot, transpose)
  } else {
    ret_plot <- ret_plot +
      ggplot2::scale_x_discrete(
        position = if (transpose) "bottom" else "top",
        limits = if (transpose) rev(names(data)) else names(data)
      ) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))
    ret_plot <- vis_add_regular_coords(ret_plot, transpose)
  }

  return(ret_plot)
}

# Time series methods: convert via tsbox to transposed data.frame, then dispatch.
#' @export
vis_binary.ts <- function(data, ...) {
  y <- ts_to_df(data)
  vis_binary.data.frame(y, ...)
}

#' @export
vis_binary.mts <- function(data, ...) {
  vis_binary.data.frame(ts_to_df(data), ...)
}

#' @export
vis_binary.zoo <- function(data, ...) {
  vis_binary.data.frame(ts_to_df(data), ...)
}

#' @export
vis_binary.xts <- function(data, ...) {
  vis_binary.data.frame(ts_to_df(data), ...)
}

#' @export
vis_binary.tbl_ts <- function(data, ...) {
  vis_binary.data.frame(ts_to_df(data), ...)
}

#' @export
vis_binary.tbl_df <- function(data, ...) {
  vis_binary.data.frame(as.data.frame(data), ...)
}

#' @export
vis_binary.tsibble <- function(data, ...) {
  vis_binary.data.frame(ts_to_df(data), ...)
}

#' @export
vis_binary.default <- function(data, ...) {
  if (tsbox::ts_boxable(data)) {
    vis_binary.data.frame(ts_to_df(data), ...)
  } else {
    stop(
      "vis_binary requires a data.frame or supported time series object",
      call. = FALSE
    )
  }
}
