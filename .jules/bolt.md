## 2024-06-11 - Optimize list mapping with base R

**Learning:** `purrr::map_lgl(x, ~ length(.x) == 0)` can be replaced with the highly optimized base R equivalent `lengths(x) == 0L`. `purrr::map_lgl(data, is.list)` can be replaced with base R `vapply(data, is.list, logical(1))` to improve performance and reduce dependencies when checking types across a list or dataframe.

**Action:** Prefer `lengths(x) == 0L` and `vapply(..., FUN.VALUE = ...)` over `purrr::map_lgl()` for type checking or length calculation on vectors/lists.
