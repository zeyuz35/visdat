## 2024-06-05 - Bolt initial setup
**Learning:** Initializing bolt journal for visdat.
**Action:** Ready to track performance improvements.

## 2024-06-05 - Optimize internal map_lgl to vapply/lengths
**Learning:** Replaced `purrr::map_lgl(x, ~ length(.x) == 0)` with the highly optimized base R equivalent `lengths(x) == 0L` in `fingerprint()`, and replaced `purrr::map_lgl(data, is.list)` with base R `vapply()` to improve performance and remove purrr dependency overhead.
**Action:** Always favor native base R vectorized logic like `lengths()` and `vapply` over `purrr::map_lgl` for tight internal iterations where types are known.
