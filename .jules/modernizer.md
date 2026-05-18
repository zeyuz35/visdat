## 2024-05-18 - Base R iterations replacement
**Learning:** Found usage of `purrr::map_lgl` for length checks and type checking. The modernization guidelines strongly advocate replacing these map functions with base R alternatives where possible for speed and to reduce external dependencies (even if the dependency is already attached, native calls are faster).
**Action:** Replaced `purrr::map_lgl(x, ~ length(.x) == 0)` with `lengths(x) == 0L` in `fingerprint` and `any(purrr::map_lgl(data, is.list))` with `any(vapply(data, is.list, logical(1)))` in `n_miss_col`.
