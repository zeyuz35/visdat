## 2024-06-03 - Modernize mapping operations to base R
**Learning:** `purrr::map_lgl()` can often be replaced by native base R functions to reduce dependencies and improve performance. Specifically, `vapply(data, FUN, logical(1))` is a safer, faster base R alternative for `map_lgl(data, FUN)`, and `lengths(x) == 0L` is much more optimized than mapping `length(.x) == 0` over a list.
**Action:** Replace `purrr::map_lgl()` calls with `vapply()` or `lengths()` where appropriate, maintaining clarity while enhancing performance.
