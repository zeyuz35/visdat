## 2024-05-24 - Vectorized assignment vs element-wise ifelse

**Learning:** Base R's `ifelse` combined with `purrr::map_lgl` for evaluating conditions element-wise across entire vectors is exceptionally slow in loops or core data-processing functions. Replacing `ifelse` with vectorized subset assignments (e.g., `res[condition] <- value`) and using base C-level functions like `lengths(x) == 0L` instead of `purrr::map_lgl(x, ~length(.x) == 0)` yields over 10x performance improvements for large dataframes. Similarly, `vapply` is much faster than `purrr::map_lgl` for type checking columns.

**Action:** Whenever identifying performance bottlenecks in R, specifically look for `ifelse` calls or mapping functions applied to base atomic structures. Replace them with pre-allocated vectors and base R vectorized operations.
