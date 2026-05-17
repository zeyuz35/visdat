## 2024-05-16 - Replacing purrr::map_lgl with base R for performance

**Learning:** `purrr::map_lgl` is used in R to map a function and return a logical vector, but base R has faster alternatives, especially `lengths(x) == 0L` for list element length checks and `vapply(x, check_func, logical(1))` for general function mapping.

**Action:** Replace `purrr::map_lgl` with these base R alternatives to eliminate overhead, reduce dependencies, and speed up critical path functions like `fingerprint` and `n_miss_col` in package internals.
