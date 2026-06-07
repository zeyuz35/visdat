## 2024-06-08 - Safe names extraction for time series metadata

**Learning:** When preserving metadata like series names from time series objects (`ts`, `zoo`, `xts`, `tsibble`), `names()` or `colnames()` can legitimately return a vector of length > 1, even if the processed dataframe only has one column. Passing this to `nzchar()` produces a logical vector, causing a "length > 1 in coercion to logical(1)" error in `if` statements. Furthermore, assigning names of incorrect length to a dataframe corrupts its structure.

**Action:** Always evaluate names arrays using `any(!is.na(x) & nzchar(x))` to prevent runtime errors, and ensure name lengths match the dataframe structure by subsetting (e.g., `series_name[1L]`) when replacing column names for a single-column dataframe.
