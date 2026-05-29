## 2024-05-29 - Optimize ifelse and map_lgl in internals

**Learning:** `ifelse` has significant performance overhead in R compared to vectorized assignments. `purrr::map_lgl` overhead can be avoided natively via `lengths()` for list length checks, and `vapply` for other type checks.
**Action:** Replace `ifelse` with pre-allocated vectors and conditional assignments (`res[condition] <- NA`). Replace `purrr::map_lgl(x, is.list)` with `vapply(x, is.list, logical(1))` for internal functions.
