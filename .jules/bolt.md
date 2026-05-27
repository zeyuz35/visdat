## 2024-05-18 - Avoid purrr and ifelse in internal iterations

**Learning:** Replacing `ifelse` and `purrr::map_lgl(x, ~ length(.x) == 0)` with vectorized base R assignments and fast base R functions (`lengths(x) == 0L`) provides significant performance gains for internal functions (like `fingerprint`) and avoids unnecessary dependencies.

**Action:** Before trying to optimize code, always identify heavy iteration loops over rows/columns or vectors, and replace `ifelse` with vectorized assignments (`res[condition] <- new_val`), and check for base R optimized alternatives like `lengths()` over `vapply()` or `purrr::map_*` for lists. Be sure to cleanup temporary files and package installation logs prior to commit!
