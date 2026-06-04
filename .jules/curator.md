## 2024-05-24 - Initial Setup
**Learning:** Initializing the curator's journal.
**Action:** Always document findings related to data integrity and attributes here.
## 2024-05-24 - Handling multi-length `names()` from multi-variate objects in `ts_to_df`
**Learning:** `names(x)` can return a character vector of length > 1 (e.g. for a multivariate zoo object where multiple columns might end up in a single dataframe check). In R >= 4.2.0, passing such a vector to `if()` throws a fatal 'length > 1 in coercion to logical(1)' error (from `nzchar()`). Also, assigning a multi-length vector to the names of a 1-column dataframe causes dimension mismatch errors (`'names' attribute must be the same length as the vector [1]`).
**Action:** Use `any(!is.na(x) & nzchar(x))` for robust emptiness checks on multi-length name vectors. And always verify `length(names(df)) == length(names_vec)` before direct assignment, defaulting to the first element otherwise to prevent silent data corruption or fatal dimension errors.
