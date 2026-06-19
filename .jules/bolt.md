## 2024-06-19 - Replacing purrr::map_lgl
**Learning:** Using base R equivalents `lengths` and `vapply` instead of `purrr::map_lgl` improves performance and reduces dependency overhead.
**Action:** Always prefer `lengths(x) == 0L` over `purrr::map_lgl(x, ~ length(.x) == 0)` and `vapply(data, is.list, logical(1))` over `purrr::map_lgl(data, is.list)`.
