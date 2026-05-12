## 2024-05-24 - Base R optimization for purrr::map_lgl

**Learning:** `purrr::map_lgl` can introduce unnecessary external dependencies overhead, especially in internal functions.
**Action:** Replaced `purrr::map_lgl(x, ~ length(.x) == 0)` with the faster `lengths(x) == 0L` and `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` to improve efficiency and reduce dependency reliance.
