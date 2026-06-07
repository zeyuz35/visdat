## 2024-05-24 - Modernize mapping functions in internals
**Learning:** Base R equivalents `lengths(x) == 0L` and `vapply()` are faster and reduce external dependency usage compared to `purrr::map_lgl()`. `ifelse()` should be retained in type-checking loops for `visdat` to properly handle factors and dimensions.
**Action:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` and `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` to optimize codebase performance.
