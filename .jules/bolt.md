## 2024-05-14 - Optimizing Element-Wise Operations
**Learning:** `ifelse()` has high evaluation overhead for conditional replacement in R. Similarly, `purrr::map_lgl()` is significantly slower than `vapply()` and base R equivalent functions like `lengths()` for determining the length of list elements.
**Action:** Replace `ifelse()` with pre-allocated vector creation (`res <- rep(val, length(x))`) and conditional subset assignment (`res[cond] <- new_val`). Prefer `lengths(x) == 0L` over `purrr::map_lgl(x, ~length(.x) == 0)` and `vapply()` over `map_lgl()` for element-wise function mapping.
