## 2024-06-04 - Type instability and length evaluation in R conditional handling

**Learning:** When evaluating names in multivariate time-series objects (e.g., `mts`), `names(x)` or `colnames(x)` legitimately returns a vector of length > 1. Passing this to `nzchar()` produces a logical vector, which throws an error ('length > 1 in coercion to logical(1)') when used in an `if` condition in R (>= 4.2.0). Additionally, `nzchar(NA)` evaluates to TRUE.

**Action:** To fix, safely evaluate using `any(!is.na(x) & nzchar(x))`. Crucially, when re-assigning names to a dataframe, ensure the length of the new names matches the dataframe's width (e.g., `if (length(names(df)) == length(valid_names))`) to safely handle multivariate objects, or fall back to assigning `valid_names[1L]` if it is a single-column dataframe to avoid dimension mismatch errors. Also, always check and delete test scratchpads or temporary logs before submitting code.
