## 2024-05-28 - Optimizing fingerprint() in R/internals.R
**Learning:** `ifelse` has a massive evaluation overhead when replacing elements conditionally in R. Vectorized conditional assignment using preallocation (`res[is.na(x)] <- NA`) is about 10x faster for atomic vectors.
Additionally, using base R `lengths(x) == 0L` is much faster than `purrr::map_lgl(x, ~ length(.x) == 0)` for list length checks, giving about ~35x speedup for list objects in the `fingerprint` function.
**Action:** Replace `ifelse()` with vectorized subset assignment, and replace `purrr::map_lgl` with `lengths(x)` in `fingerprint()` function inside `R/internals.R`.
