## 2024-05-31 - Modernize fingerprint function to replace element-wise ifelse with vectorized assignment

**Learning:** The `fingerprint` function in `R/internals.R` uses `ifelse()` and `purrr::map_lgl(x, ~ length(.x) == 0)` element-wise to check for `NA` or length-0 lists. This is exceptionally slow due to element-wise operations on large vectors. Vectorized assignment (`res[is.na(x)] <- NA`) and the base R `lengths()` function are orders of magnitude faster. `lengths(x) == 0L` is the highly optimized base R equivalent to `purrr::map_lgl(x, ~ length(.x) == 0)`.

**Action:** Replace `ifelse()` calls in `fingerprint` with vectorized assignment. Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L`.
