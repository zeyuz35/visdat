## 2024-05-13 - Replace purrr::map_lgl with base R lengths
**Learning:** `purrr::map_lgl(x, ~ length(.x) == 0)` can be optimized to `lengths(x) == 0L` in R. It improves performance by dropping the `purrr` dependency and function overhead. Memory mentions "For list length checks, use the highly optimized base R lengths(x) == 0L instead of purrr::map_lgl or vapply."
**Action:** Replaced `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` in `R/internals.R`.
