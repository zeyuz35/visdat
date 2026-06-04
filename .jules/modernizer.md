## 2024-06-04 - Refactoring purrr::map_lgl to base R functions
**Learning:** `purrr::map_lgl` can often be replaced by native, high-performance base R equivalents like `lengths(x) == 0L` (instead of mapping length checks) and `vapply(data, is.list, logical(1))` (instead of mapping `is.list`). This improves performance and reduces dependency bloat.
**Action:** Always look for opportunities to replace simple `purrr::map_*` calls with native vectorized functions (`lengths()`, `rowSums()`, etc.) or `vapply` when looping over lists/dataframes for type checking.
