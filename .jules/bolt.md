## 2024-05-24 - Performance Optimizations in R internals

**Learning:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with the highly optimized base R equivalent `lengths(x) == 0L`. Replace `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` to improve performance and reduce dependencies when checking types across a list or dataframe.
**Action:** I will update the code in `R/internals.R` to use these native base R vectorized and apply functions instead of `purrr`.
