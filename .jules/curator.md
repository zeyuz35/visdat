## 2024-05-24 - Handle nzchar with length > 1 and NA correctly
**Learning:** When evaluating names in time-series objects, `names(x)` may return a vector of length > 1. Passing this to `nzchar()` produces a logical vector, which throws an error (`'length > 1' in coercion to 'logical(1)'`) when used in an `if` condition in R (>= 4.2.0). Additionally, `nzchar(NA)` evaluates to TRUE, potentially passing checks erroneously and causing NA coercion errors.
**Action:** Extract the first element safely and check it with `!is.null(x) && !is.na(x[1]) && nzchar(x[1])`.
## 2024-05-24 - Handle names(series_df) <- series_name length mismatch
**Learning:** If `series_name` extracted from `names(x)` has length > 1 (e.g. elements of a vector instead of column names), `names(series_df) <- series_name` throws an error because `series_df` only has 1 column for `ts` class objects.
**Action:** When conditionally replacing the column name of `series_df` using `series_name`, only extract the first name `series_name[1]` to match `series_df` length.
