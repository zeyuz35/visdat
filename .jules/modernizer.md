## 2024-06-06 - Replacing purrr::map_lgl with base alternatives

**Learning:** In the visdat package, `purrr::map_lgl(data, is.list)` and `purrr::map_lgl(x, ~ length(.x) == 0)` can be replaced with `vapply(data, is.list, logical(1))` and `lengths(x) == 0L` to improve performance and remove the purrr dependency for type checking.

**Action:** Use base alternatives to speed up internal helper functions while maintaining correct behavior and avoiding recycling errors in `ifelse()`.