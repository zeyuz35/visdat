## 2024-05-18 - Refactor ifelse and map_lgl to vectorized ops
**Learning:** Avoid `ifelse()` for element-wise conditional replacement due to significant evaluation overhead. Prefer pre-allocating a result vector and using vectorized subset assignment. Replace `map_lgl` with base R `vapply` or `lengths()` for list size checks.
**Action:** Refactored `fingerprint` and `n_miss_col` to avoid `ifelse` overhead and external `purrr` dependencies in internal R functions.
