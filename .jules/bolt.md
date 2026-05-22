## 2024-05-22 - Optimize element-wise logical checks and assignments
**Learning:** In base R, using `ifelse()` for element-wise conditional replacement introduces significant evaluation overhead. Additionally, calculating list lengths using `purrr::map_lgl(x, ~ length(.x) == 0)` or `vapply` is much slower than using the highly optimized base R `lengths(x) == 0L`.
**Action:** Replace `ifelse()` with pre-allocating a result vector and using vectorized subset assignment (e.g., `res[is.na(x)] <- NA`). Replace mapping length checks over lists with base R `lengths()`.
