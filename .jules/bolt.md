## 2024-06-22 - Optimize purrr::map_lgl checks
**Learning:** Checking types across a dataframe (like checking if there are list columns) using `purrr::map_lgl(data, is.list)` is slower than using base R's `vapply`. Also, `purrr::map_lgl(x, ~ length(.x) == 0)` inside an `ifelse` can be replaced with `lengths(x) == 0L` to optimize performance.
**Action:** Replace `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` and `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` to improve performance without introducing dependencies.
