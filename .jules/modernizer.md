## 2024-05-24 - Base R modernization and performance optimization
**Learning:** `ifelse()` has high evaluation overhead for element-wise conditional replacement. Also, `lengths(x)` / `vapply()` perform significantly faster than `purrr::map_lgl()` while removing unnecessary dependency footprints.
**Action:** Prioritize pre-allocating result vectors and subset assignment over `ifelse()`. Use base R `lengths(x)` and `vapply` instead of `purrr::map_*` mappings in performance-sensitive and internal utility routines.
