#' Visually compare two dataframes and see where they are different.
#'
#' `vis_compare`, like the other `vis_*` families, gives an at-a-glance ggplot
#'   of a dataset, but in this case, hones in on visualising **two** different
#'   dataframes of the same dimension, so it takes two dataframes as arguments.
#'
#' @param df1 The first dataframe to compare
#'
#' @param df2 The second dataframe to compare to the first.
#'
#' @return `ggplot2` object displaying which values in each data frame are
#'   present in each other, and which are not.
#'
#' @seealso [vis_miss()] [vis_dat()] [vis_guess()] [vis_expect()] [vis_cor()]
#'
#' @examples
#'
#' # make a new dataset of iris that contains some NA values
#' aq_diff <- airquality
#' aq_diff[1:10, 1:2] <- NA
#' vis_compare(airquality, aq_diff)
#' @export
vis_compare <- function(df1, df2, ...) UseMethod("vis_compare")

#' @export
vis_compare.data.frame <- function(df1, df2, transpose = FALSE, ...){

  # could add a parameter, sort_match, to help with
  # sort_match logical TRUE/FALSE.
  # TRUE arranges the columns in order of most matches.

  test_if_dataframe(df1)
  test_if_dataframe(df2)

  if (!identical(dim(df1), dim(df2))) {
    cli::cli_abort(
      c(
        "{.fun vis_compare} requires identical dimensions of {.arg df1} and \\
        {.arg df2}",
        "The dimensions of {.arg df1} are: {dim(df1)}",
        "The dimensions of {.arg df2} are: {dim(df2)}"
        )
    )
  }

  v_identical <- Vectorize(identical)

  df_diff <- purrr::map2_df(df1, df2, v_identical)

  d <- df_diff |>
    as.data.frame() |>
    purrr::map_df(compare_print) |>
    vis_gather_() |>
    dplyr::mutate(value_df1 = vis_extract_value_(df1),
                  value_df2 = vis_extract_value_(df2))

  # then we plot it
  vis_compare_plot <- ggplot2::ggplot(data = d,
                                      ggplot2::aes(
                                        x = variable,
                                        y = rows)) +
    ggplot2::geom_raster(ggplot2::aes(fill = valueType)) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                                       vjust = 1,
                                                       hjust = 1)) +
    ggplot2::labs(x = "",
                  y = "Observations",
                  fill = "Cell Type") +
    ggplot2::scale_fill_manual(limits = c("same",
                                          "different"),
                               breaks = c("same",
                                          "different"),
                               values = c("#fc8d59",
                                          "#91bfdb"),
                               na.value = "grey") +
    ggplot2::guides(fill = ggplot2::guide_legend(reverse = TRUE, title = "Cell Type"))

  row_labels <- attr(df1, "row_labels")
  
  if (!is.null(row_labels)) {
    vis_compare_plot$data$time <- as.Date(row_labels[vis_compare_plot$data$rows])
    vis_compare_plot$layers[[1]] <- NULL
    
    vis_compare_plot <- vis_compare_plot +
      ggplot2::geom_tile(ggplot2::aes(x = variable, y = time, fill = valueType)) +
      ggplot2::scale_y_date(expand = c(0, 0)) +
      ggplot2::scale_x_discrete(position = ifelse(transpose, "bottom", "top"), limits = if(transpose) rev(names(df_diff)) else names(df_diff)) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.25))
      
    if (transpose) {
      vis_compare_plot <- vis_compare_plot + ggplot2::coord_flip()
    } else {
      vis_compare_plot <- vis_compare_plot + ggplot2::coord_trans(y = "reverse")
    }
    vis_compare_plot <- vis_compare_plot + 
      ggplot2::labs(x = if(transpose) "Time" else "Series", y = if(transpose) "Series" else "Time")
  } else {
    vis_compare_plot <- vis_compare_plot +
      ggplot2::scale_x_discrete(position = ifelse(transpose, "bottom", "top"), limits = if(transpose) rev(names(df_diff)) else names(df_diff)) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.25))

    if (transpose) {
      vis_compare_plot <- vis_compare_plot + 
        ggplot2::coord_flip() + 
        ggplot2::scale_y_continuous() +
        ggplot2::labs(x = "Observations", y = "")
    } else {
      vis_compare_plot <- vis_compare_plot + 
        ggplot2::scale_y_reverse() +
        ggplot2::labs(x = "", y = "Observations")
    }
  }

  vis_compare_plot
}

# Time series methods: convert via tsbox to transposed data.frame, then dispatch.
#' @export
vis_compare.ts <- function(df1, df2, ...) {
  y1 <- ts_to_df(df1)
  y2 <- ts_to_df(df2)
  vis_compare.data.frame(y1, y2, ...)
}

#' @export
vis_compare.mts <- function(df1, df2, ...) {
  vis_compare.data.frame(ts_to_df(df1), ts_to_df(df2), ...)
}

#' @export
vis_compare.zoo <- function(df1, df2, ...) {
  vis_compare.data.frame(ts_to_df(df1), ts_to_df(df2), ...)
}

#' @export
vis_compare.xts <- function(df1, df2, ...) {
  vis_compare.data.frame(ts_to_df(df1), ts_to_df(df2), ...)
}

#' @export
vis_compare.tbl_ts <- function(df1, df2, ...) {
  vis_compare.data.frame(ts_to_df(df1), ts_to_df(df2), ...)
}

#' @export
vis_compare.tbl_df <- function(df1, df2, ...) {
  vis_compare.data.frame(as.data.frame(df1), as.data.frame(df2), ...)
}

#' @export
vis_compare.tsibble <- function(df1, df2, ...) {
  vis_compare.data.frame(ts_to_df(df1), ts_to_df(df2), ...)
}

#' @export
vis_compare.default <- function(df1, df2, ...) {
  if (tsbox::ts_boxable(df1) && tsbox::ts_boxable(df2)) {
    vis_compare.data.frame(ts_to_df(df1), ts_to_df(df2), ...)
  } else {
    stop(
      "vis_compare requires data.frames or supported time series objects",
      call. = FALSE
    )
  }
}

#' (Internal) A utility function for `vis_compare`
#'
#' `compare_print` is an internal function that takes creates a dataframe with
#'   information about where there are differences in the dataframe. This
#'   function is used in `vis_compare`. It evaluates on the data `(df1 == df2)`
#'   and (currently) replaces the "true" (the same) with "Same"
#'   and FALSE with "Different", unless it is missing (coded as NA), in which
#'   case it leaves it as NA.
#'
#' @param x a vector
#' @keywords internal
#' @noRd
#'
compare_print <- function(x){

  dplyr::if_else(x == "TRUE",
                 true = "same",
                 false = "different",
                 missing = "missing")


} # end function

