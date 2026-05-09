## 2024-05-09 - Fast Data Type Fingerprinting

**Learning:** The `visdat` package heavily relies on `visdat:::fingerprint()` (via `fingerprint_df()`) to extract column types, which is called on every element of the input dataframe during plot generation. The previous implementation used `ifelse()` and `purrr::map_lgl()`, which proved to be significant bottlenecks (~13ms for a 100k vector, ~153ms for a 100k list). Vectorized base R replacements (`res[is.na(x)] <- NA` and `lengths(x) == 0L`) are an order of magnitude faster (~1.5ms for vector, ~3.4ms for list).

**Action:** When extracting or conditionally modifying column metadata in performance-critical data visualization paths, strictly avoid `ifelse()` and `purrr` iterators in favor of vectorized base R subset assignments.
