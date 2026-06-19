## 2024-06-19 - Replace purrr loops with base R vectorization
**Learning:** Using `purrr::map_lgl()` for simple checks like `is.list` or checking lengths adds function call overhead that can be avoided with native base R constructs like `vapply()` or `lengths()`.
**Action:** Replace `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` and `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` to improve performance without losing readability.
