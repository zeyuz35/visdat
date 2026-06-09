## 2024-05-24 - Modernizing iterators in internal functions

**Learning:** Replaced `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` and `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))`. These replacements reduce dependency overhead, improve execution speed of type checking across lists/dataframes, and are native R equivalents.

**Action:** Use native base R vectorization (`lengths`, `vapply`) over `purrr::map_*` functions whenever possible to improve performance and reduce dependency bloat, especially in internal utilities running across large objects. Keep `ifelse()` when its specific casting and recycling behaviors are needed, even if slightly slower than vector assignment.
