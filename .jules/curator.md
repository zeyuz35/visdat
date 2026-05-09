## 2024-05-09 - nzchar length > 1 coercion issue with univariate time series

**Learning:** When evaluating character vectors for names in univariate time-series objects (e.g., `ts`), `names(x)` may return a vector of element names with length > 1. To avoid 'length > 1 in coercion to logical(1)' errors, safeguard `nzchar()` checks with a length validation like `length(series_name) == 1L`.

**Action:** Ensure that character length validations like `nzchar()` are always wrapped with a length check when pulling names from objects that can arbitrarily assign names to individual elements rather than whole objects.
