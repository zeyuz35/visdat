## 2024-05-24 - Avoid ifelse() and purrr::map_lgl() for simple list checks
**Learning:** `ifelse()` combined with `purrr::map_lgl()` is extremely slow for element-wise conditional replacement, especially for list checks.
**Action:** Use pre-allocation and vectorized subset assignment (e.g., `res[is.na(x)] <- NA`) and `lengths(x) == 0L` instead of `ifelse()` and `purrr::map_lgl()` to improve performance and remove purrr dependency.
