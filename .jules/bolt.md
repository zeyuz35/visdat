## 2024-06-22 - Optimize `purrr::map_lgl` with base R equivalents

**Learning:** The `purrr::map_lgl` function carries a significant overhead compared to native base R vectorized approaches, particularly for simple list checks (`is.list`) and emptiness tests (`~ length(.x) == 0`).

**Action:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with the vectorized base function `lengths(x) == 0L`. Similarly, replace `purrr::map_lgl(x, is.list)` with `vapply(x, is.list, logical(1))` for substantially faster execution and reduced dependency calls inside frequently executed routines.
