## 2024-05-24 - Optimize Type Checking
**Learning:** Using `lengths(x) == 0L` is much faster than `purrr::map_lgl(x, ~ length(.x) == 0)` and `vapply(data, is.list, logical(1))` is faster than `purrr::map_lgl(data, is.list)` while removing a layer of dependency evaluation.
**Action:** Always prefer `lengths()` for zero-length checking and `vapply()` for simple, uniform type checks across columns/lists in performance-sensitive iterations.
