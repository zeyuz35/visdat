## 2024-05-18 - ts_to_df names length handling

**Learning:** When evaluating character vectors for names in univariate time-series objects (like `ts` or `zoo`), `names(x)` may return a vector of length > 1 if element names are assigned, but the time series only contains one actual column of data values. When this is evaluated inside an `nzchar()` without a `length() == 1` check, it throws a "length > 1 in coercion to logical(1)" error.

**Action:** Always ensure that `nzchar()` evaluations on dynamically extracted metadata (like names attributes) are safeguarded with length validations (e.g., `length(series_name) == 1L`) to prevent vectorization errors.
