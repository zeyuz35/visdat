## 2024-05-27 - Vectorized Subset Assignment over `ifelse` in `fingerprint` function

**Learning:** `ifelse()` introduces significant evaluation overhead for element-wise conditional replacement in R, especially for basic types or lists. Additionally, using `purrr::map_lgl(x, ~ length(.x) == 0)` involves external dependency calls overhead inside a loop or function which can be quite slow.

**Action:** Prefer pre-allocating a result vector and using vectorized subset assignment (e.g., `res[is.na(x)] <- NA`). For list length checks, use the highly optimized base R primitive `lengths(x) == 0L` instead of `purrr::map_lgl` or `vapply`.
