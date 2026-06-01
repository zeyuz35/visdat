## 2024-05-24 - Optimize list missingness and element-wise replacements
**Learning:** `purrr::map_lgl(x, ~ length(.x) == 0)` and `ifelse()` create significant overhead for element-wise missingness checks and replacements, especially on large datasets.
**Action:** Use base R vectorized operations: `lengths(x) == 0L` for empty list elements, and pre-allocate vectors (`res[condition] <- NA`) instead of `ifelse()`.
