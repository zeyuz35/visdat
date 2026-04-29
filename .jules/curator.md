## 2024-04-28 - Avoid boolean length coercion on multiple element names in time series objects

**Learning:** When a univariate `ts` object has its elements individually named rather than just having a series name (e.g. `names(x) <- letters[1:10]`), checking `nzchar(names(x))` returns a logical vector of the same length. This causes a `length > 1 in coercion to logical(1)` error when evaluated inside an `if` statement (specifically in `ts_to_df`).

**Action:** Always ensure the length is exactly 1 when verifying character conditions (e.g. `length(series_name) == 1L`) before checking `nzchar()`, especially in general-purpose coercion functions like `ts_to_df` that process input from various packages.
