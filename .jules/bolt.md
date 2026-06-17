## 2024-05-18 - Optimized list type check via base R `vapply` and `lengths`
**Learning:** Found an opportunity to replace `purrr::map_lgl(x, ~ length(.x) == 0)` with base R `lengths(x) == 0L` and `any(purrr::map_lgl(data, is.list))` with `any(vapply(data, is.list, logical(1)))` in `R/internals.R`. Benchmarks confirm `lengths(x) == 0L` is around ~30x faster and `vapply(..., is.list, logical(1))` is around 4x faster compared to the purrr equivalents.
**Action:** Proceed with applying these optimizations to `R/internals.R` and ensure tests pass.
