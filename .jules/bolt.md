## 2026-06-03 - Replace purrr mapping with fast base R alternatives
**Learning:** R profiling shows that purrr map functions within inner loops (like internals.R's fingerprint and missingness checking) are measurably slower than vectorised base R alternatives. Replacing `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` and `purrr::map_lgl(data, is.list)` with `vapply(data, is.list, logical(1))` yields performance improvements.
**Action:** Use base vectorized R functions (e.g., lengths, vapply) instead of purrr map logic when optimizing dataframe or list processing hot loops.
