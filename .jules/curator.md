## 2024-05-28 - Conditionally check length and use any() on nzchar() to prevent 'length > 1 in coercion to logical(1)' errors

**Learning:** When passing names or colnames from a multi-series object to nzchar(), it may legitimately return a logical vector of length > 1. Evaluating this in an `if` condition using R >= 4.2.0 causes an error 'length > 1 in coercion to logical(1)'.

**Action:** Replace `!is.null(names) && nzchar(names)` with `!is.null(names) && any(!is.na(names) & nzchar(names))`. Also, if you plan to rename a dataframe using a name vector, ensure the length of the new names matches the dataframe's width (e.g., `if (length(names(df)) == length(valid_names))`) to safely handle multivariate objects, or fall back to assigning `valid_names[1L]` if it is a single-column dataframe to avoid dimension mismatch errors.
