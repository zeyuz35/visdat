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
#' df <-  stats::setNames(dat_bin, c("1.1", "8.9", "10.4"))
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

  vis_binary_plot <- data %>%
    vis_gather_() %>%
    dplyr::mutate(value = vis_extract_value_(data)) %>%
    dplyr::mutate(valueType = forcats::as_factor(valueType),
                  value = forcats::as_factor(value),
                  variable = forcats::fct_relevel(variable, order)) %>%
    vis_create_() +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    ggplot2::scale_fill_manual(values = c(col_zero, # zero
                                          col_one), # one
                               na.value = col_na)

  row_labels <- attr(data, "row_labels")
  
  if (!is.null(row_labels)) {
    vis_binary_plot$data$time <- as.Date(row_labels[vis_binary_plot$data$rows])
    vis_binary_plot$layers[[1]] <- NULL
    
    vis_binary_plot <- vis_binary_plot +
      ggplot2::geom_tile(ggplot2::aes(x = variable, y = time, fill = valueType)) +
      ggplot2::scale_y_date(expand = c(0, 0)) +
      ggplot2::scale_x_discrete(position = ifelse(transpose, "bottom", "top"), limits = if(transpose) rev(names(data)) else names(data)) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))
      
    if (transpose) {
      vis_binary_plot <- vis_binary_plot + ggplot2::coord_flip()
    } else {
      vis_binary_plot <- vis_binary_plot + ggplot2::coord_trans(y = "reverse")
    }
    vis_binary_plot <- vis_binary_plot + 
      ggplot2::labs(x = if(transpose) "Time" else "Series", y = if(transpose) "Series" else "Time")
  } else {
    vis_binary_plot <- vis_binary_plot +
      ggplot2::scale_x_discrete(position = ifelse(transpose, "bottom", "top"), limits = if(transpose) rev(names(data)) else names(data)) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))

    if (transpose) {
      vis_binary_plot <- vis_binary_plot + 
        ggplot2::coord_flip() + 
        ggplot2::scale_y_continuous() +
        ggplot2::labs(x = "Observations", y = "")
    }
  }
  
  vis_binary_plot
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
