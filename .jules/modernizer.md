## 2024-05-18 - Base R Alternatives to Purrr
**Learning:** `lengths()` and `vapply(..., logical(1))` can seamlessly replace `purrr::map_lgl` and map list length checks in internal functions, reducing dependency overhead and slightly improving performance. Vectorized assignment (`res[is.na(x)] <- NA`) is also a highly performant alternative to `ifelse()`.
**Action:** Always prefer native R functions (`lengths`, `vapply`, vectorized indexing) over `purrr::map_*` and `ifelse()` when implementing or modernizing internal package utility functions.
