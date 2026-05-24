## 2024-05-24 - Fix nzchar length > 1 error in ts_to_df

**Learning:** When evaluating names in multivariate time-series objects (e.g., `mts`), `names(x)` or `colnames(x)` legitimately returns a vector of length > 1. Passing this to `nzchar()` produces a logical vector, which throws an error ('length > 1 in coercion to logical(1)') when used in an `if` condition in R (>= 4.2.0). Additionally, `nzchar(NA)` evaluates to TRUE.

**Action:** Do not enforce a length of 1, as this drops metadata for multi-column objects. Instead, safely evaluate the vector using `any(!is.na(x) & nzchar(x))` to determine if valid names exist.
