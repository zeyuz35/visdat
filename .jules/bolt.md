## 2024-06-25 - purrr::map_lgl vs base R for logical checks
**Learning:** Checking length 0 with `purrr::map_lgl(x, ~ length(.x) == 0)` takes ~100us while `lengths(x) == 0L` takes ~1us, making base R 100x faster for this operation. Similarly, `vapply(data, is.list, logical(1))` is 2x faster than `purrr::map_lgl(data, is.list)`.
**Action:** Replace `purrr::map_lgl` with native R equivalents like `lengths() == 0L` or `vapply()` for simple iteration where performance can be optimized.
