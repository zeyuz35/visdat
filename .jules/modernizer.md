## 2024-05-30 - Modernization Insights

**Learning:** `purrr::map_lgl` and `ifelse` for element-wise checking in `R/internals.R` can be significantly optimized and modernized using base R alternatives (`vapply`, pre-allocation with vectorized assignment, or `lengths`).
**Action:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with base R's `lengths(x) == 0L`. Replace `ifelse` with vectorized assignment. Replace `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` or `any(vapply(...))`.
