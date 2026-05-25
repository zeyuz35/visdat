## 2024-05-26 - Fix nzchar length coercion error in time-series names

**Learning:** Passing a vector of length > 1 (which frequently happens for multivariate time-series element names) to `nzchar()` produces a logical vector, causing an error when used in a scalar `if` condition in R >= 4.2.0. Additionally, `nzchar(NA)` evaluates to TRUE.

**Action:** Safely evaluate string vectors using `any(!is.na(x) & nzchar(x))` to determine if valid names exist without enforcing a length of 1, which preserves metadata for multi-column objects.
