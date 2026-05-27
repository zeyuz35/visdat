## 2024-05-27 - Fix length > 1 logical coercion for time series names
**Learning:** When evaluating names in multivariate time-series objects (e.g., mts, ts), `names(x)` legitimately returns a vector of length > 1. Passing this to `nzchar()` produces a logical vector, throwing 'length > 1 in coercion to logical(1)' in R >= 4.2.0 `if` statements. Also `nzchar(NA)` is TRUE.
**Action:** Safely evaluate the vector using `any(!is.na(x) & nzchar(x))` to determine if valid names exist, and assign the first valid name.
