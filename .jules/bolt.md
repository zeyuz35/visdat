## 2024-05-20 - Optimize ifelse in fingerprint function
**Learning:** `ifelse()` is notoriously slow in R for element-wise conditional replacements because it evaluates conditions, evaluates yes/no clauses fully, and performs a lot of attribute handling.
**Action:** Replace `ifelse()` with pre-allocation and vectorized subset assignment (e.g., `res[is.na(x)] <- NA`). Also replace `purrr::map_lgl(x, ~ length(.x) == 0)` with the much faster base R `lengths(x) == 0L`.
