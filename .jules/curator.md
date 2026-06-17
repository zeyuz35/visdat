## 2024-06-16 - Safe nzchar evaluation for names in multivariate and named time-series objects

**Learning:** When evaluating names in multivariate or named time-series objects, `names(x)` can return a vector of length > 1. Passing this to `nzchar()` produces a logical vector, throwing a 'length > 1 in coercion to logical(1)' error when used in an `if` condition in R (>= 4.2.0). Additionally, `nzchar(NA)` evaluates to TRUE.

**Action:** Safely evaluate using `any(!is.na(x) & nzchar(x))`. When re-assigning names to a dataframe, ensure the length of the new names matches the dataframe's width (e.g., `if (length(names(df)) == length(valid_names))`) to handle multivariate objects, or fall back to assigning `valid_names[1L]` if it is a single-column dataframe to avoid dimension mismatch errors.
