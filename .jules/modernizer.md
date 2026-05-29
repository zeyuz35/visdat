## 2024-05-29 - Vectorizing internals to avoid map_lgl and ifelse
**Learning:** `ifelse()` is known to be slow for element-wise evaluation, and `purrr::map_lgl` adds external call overhead for simple list length checks.
**Action:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with base `lengths(x) == 0L`, and replace `ifelse` with pre-allocated vector and vectorized subset replacement for massive performance gains in utility functions. Use `vapply` instead of `purrr::map_lgl` for type-checking dataframe columns natively.
