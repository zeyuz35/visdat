#' Visualise the value of data values
#'
#' Visualise all of the values in the data on a 0 to 1 scale. Only works on
#'   numeric data - see examples for how to subset to only numeric data.
#'
#' @param data a data.frame
#' @param na_colour a character vector of length one describing what colour
#'   you want the NA values to be. Default is "grey90"
#' @param viridis_option A character string indicating the colormap option to
#'   use. Four options are available: "magma" (or "A"), "inferno" (or "B"),
#'   "plasma" (or "C"), "viridis" (or "D", the default option) and "cividis"
#'   (or "E").
#'
#' @return a ggplot plot of the values
#' @export
#'
#' @examples
#'
#' vis_value(airquality)
#' vis_value(airquality, viridis_option = "A")
#' vis_value(airquality, viridis_option = "B")
#' vis_value(airquality, viridis_option = "C")
#' vis_value(airquality, viridis_option = "E")
#' \dontrun{
#' library(dplyr)
#' diamonds |>
#'   dplyr::select(where(is.numeric)) |>
#'   vis_value()
#'}
vis_value <- function(data, ...) UseMethod("vis_value")

#' @export
vis_value.data.frame <- function(
  data,
  na_colour = "grey90",
  viridis_option = "D",
  transpose = FALSE,
  ...
) {
  test_if_all_numeric(data)

  vis_data <- purrr::map_dfr(data, scale_01) |>
    vis_gather_() |>
    dplyr::mutate(
      value = vis_extract_value_(data),
      value = as.numeric(value),
      valueType = as.numeric(valueType)
    )

  ret_plot <- vis_create_(vis_data) +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    ggplot2::scale_fill_viridis_c(option = viridis_option, na.value = na_colour)

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
vis_value.ts <- function(data, ...) {
  y <- ts_to_df(data)
  vis_value.data.frame(y, ...)
}

#' @export
vis_value.mts <- function(data, ...) {
  vis_value.data.frame(ts_to_df(data), ...)
}

#' @export
vis_value.zoo <- function(data, ...) {
  vis_value.data.frame(ts_to_df(data), ...)
}

#' @export
vis_value.xts <- function(data, ...) {
  vis_value.data.frame(ts_to_df(data), ...)
}

#' @export
vis_value.tbl_ts <- function(data, ...) {
  vis_value.data.frame(ts_to_df(data), ...)
}

#' @export
vis_value.tbl_df <- function(data, ...) {
  vis_value.data.frame(as.data.frame(data), ...)
}

#' @export
vis_value.tsibble <- function(data, ...) {
  vis_value.data.frame(ts_to_df(data), ...)
}

#' @export
vis_value.default <- function(data, ...) {
  if (tsbox::ts_boxable(data)) {
    vis_value.data.frame(ts_to_df(data), ...)
  } else {
    stop(
      "vis_value requires a data.frame or supported time series object",
      call. = FALSE
    )
  }
}
