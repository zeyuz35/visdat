## 2024-06-02 - Data Integrity Check for ts_to_df

**Learning:** `ts_to_df` function in `R/internals.R` converts various time series classes into a `data.frame`. A critical data integrity issue occurs if names are lost.
`visdat` relies on `names()` or `colnames()`.
**Action:** Inspect `ts_to_df` to ensure attributes and names are preserved.
