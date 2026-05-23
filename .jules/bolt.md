## 2024-05-23 - Vectorize `fingerprint` function to avoid `ifelse` overhead

**Learning:** `ifelse()` has massive overhead in R when called repeatedly on elements due to evaluation logic and attribute tracking. Also, checking for empty elements in list columns via `purrr::map_lgl(x, ~length(.x) == 0)` incurs a massive function-call overhead compared to base R's vectorized `lengths(x) == 0L`.
**Action:** Always prefer pre-allocating a vector and using subset assignment (e.g., `res[is.na(x)] <- NA`) instead of `ifelse()`, and use the C-level base R `lengths()` function instead of mapping R functions over lists to calculate length.
