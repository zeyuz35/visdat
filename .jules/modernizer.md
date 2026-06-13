## 2025-02-24 - Replace `purrr::map_lgl` with `vapply`/`lengths`

**Learning:** Memory states: Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with the highly optimized base R equivalent `lengths(x) == 0L`. Also replace `purrr::map_lgl(data, is.list)` with base R `vapply(data, is.list, logical(1))` to improve performance and reduce dependencies.
**Action:** In `R/internals.R`, I will find usages of `purrr::map_lgl` and replace them with `lengths(x) == 0L` and `vapply(data, is.list, logical(1))`.
