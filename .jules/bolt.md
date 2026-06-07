## 2024-05-24 - Base R Optimization
**Learning:** `purrr::map_lgl(x, ~ length(.x) == 0)` and `purrr::map_lgl(data, is.list)` are used for type and length checking. They are slower than native base R functions `lengths(x) == 0L` and `vapply(data, is.list, logical(1))`.
**Action:** Replace `purrr::map_lgl` with `lengths` and `vapply` for improved performance.
