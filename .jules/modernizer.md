## 2024-05-15 - Modernize list and length checks in `internals.R`

**Learning:** `purrr::map_lgl` is significantly slower than base R's native features like `vapply(..., logical(1))` and `lengths() == 0L` when performing element-wise conditional checks or list length evaluations. Specifically, `lengths(x) == 0L` is extremely fast and `vapply` avoids the overhead of mapping functions.
**Action:** Replace `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` and replace `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` to improve performance while maintaining exact behavior.
