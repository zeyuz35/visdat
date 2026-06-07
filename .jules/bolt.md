## 2024-06-08 - Base R vectorization for type checking and lengths
**Learning:** Using `purrr::map_lgl(x, ~ length(.x) == 0)` and `purrr::map_lgl(data, is.list)` introduces unnecessary overhead in internal functions. Base R `lengths(x) == 0L` and `vapply(data, is.list, logical(1))` are highly optimized and significantly faster.
**Action:** When refactoring internal loops for type checking or length calculation, prefer base R vectorization (`lengths()`, `vapply()`) over `purrr::map_lgl()` to improve performance and reduce dependencies.
