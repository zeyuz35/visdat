## 2024-05-28 - Replace purrr::map_lgl with base R functions

**Learning:** Using purrr::map_lgl(x, ~ length(.x) == 0) can be replaced by the highly optimized base R equivalent lengths(x) == 0L. Checking types across a dataframe with purrr::map_lgl(data, is.list) can be improved in performance and dependency footprint by using base R vapply(data, is.list, logical(1)). Keep ifelse structures intact to maintain factor/dimension properties when refactoring inner logic.
**Action:** Replace purrr::map_lgl with lengths or vapply when possible to improve performance and native dependency usage in performance-critical paths.
