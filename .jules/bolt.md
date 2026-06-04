## 2024-06-04 - Optimize logical list mapping and length checks
**Learning:** `purrr::map_lgl(x, is.list)` is slower and adds a dependency footprint compared to `vapply(x, is.list, logical(1))`. Also, `purrr::map_lgl(x, ~ length(.x) == 0)` can be optimized with native, vectorized `lengths(x) == 0L`.
**Action:** Use base R equivalents (`vapply` with strict type, `lengths`) for checking types and lengths to improve performance, especially inside internal type-checking loops.
