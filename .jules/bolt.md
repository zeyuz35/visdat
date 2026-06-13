## 2024-06-13 - Replace purrr::map_lgl with base R alternatives
**Learning:** `purrr::map_lgl()` can be a performance bottleneck when checking properties across elements of a list or dataframe columns. Base R provides optimized vectorised functions like `lengths()` and `vapply()` that avoid internal overheads.
**Action:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with the vectorized base function `lengths(x) == 0L`. Similarly, replace `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` for more efficient type checking across lists or dataframe columns.
