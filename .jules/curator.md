## 2024-05-24 - R >= 4.2.0 Length > 1 and NA in `if` conditions

**Learning:** When evaluating names in time-series objects (e.g., `ts`, `mts`) in `visdat`, `names(x)` or `colnames(x)` may return a vector of length > 1. Passing this directly to `if (nzchar(series_name))` throws a fatal error in R (>= 4.2.0) because `if` requires a logical vector of exactly length 1. Furthermore, `nzchar(NA)` incorrectly evaluates to TRUE, potentially passing the condition erroneously.

**Action:** Whenever checking names or attributes that might evaluate to a character vector (including `character(0)` which becomes `NA` when indexed), extract the first element explicitly and add `!is.na(x[1])`. The safe check is `if (!is.null(x) && !is.na(x[1]) && nzchar(x[1]))`. Also, make sure assignments such as `names(df) <- x` use `x[1]` when the target has only 1 column to avoid length mismatch errors.
