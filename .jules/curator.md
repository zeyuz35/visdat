## 2026-04-24 - Prevent coercion errors for named univariate ts objects

**Learning:** When coercing univariate time series (ts) to a data.frame, `names(x)` can return a vector of element names with length > 1, instead of a single series name. Passing this directly to `nzchar()` inside a conditional check triggers a 'length > 1 in coercion to logical(1)' error, completely breaking downstream pipeline processing.

**Action:** Always constrain character vector validations applied to metadata dynamically drawn from `names()` with an explicit length safeguard like `length(series_name) == 1L`.
