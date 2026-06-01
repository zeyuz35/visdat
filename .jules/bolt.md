## 2024-06-25 - Avoid ifelse and purrr::map_lgl for basic conditional replacements and type checks

**Learning:** `ifelse` is notoriously slow for basic element-wise replacements due to attribute handling overhead. `purrr::map_lgl` introduces functional programming overhead compared to base R primitives.

**Action:** Replace `ifelse(condition, NA, value)` with pre-allocated vectors and vectorized subsetting `res[condition] <- NA`. Replace `purrr::map_lgl(list, is.list)` with `vapply(list, is.list, logical(1))` and `purrr::map_lgl(list, ~ length(.x) == 0)` with the internal C-level `lengths(list) == 0L` to achieve massive speedups.
