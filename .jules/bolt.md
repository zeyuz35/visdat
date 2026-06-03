## 2024-06-03 - Base R Optimizations over purrr in visdat
**Learning:** `purrr::map_lgl()` can be replaced with base R `lengths(x) == 0L` and `vapply(data, is.list, logical(1))` to improve performance when checking list properties across large dataframes.
**Action:** Use `lengths(x) == 0L` instead of mapping `length(.x) == 0` for list emptiness checks, and `vapply()` over `map_lgl()` for type checks to avoid overhead.
