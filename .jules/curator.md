## 2024-05-15 - Missing length check in named character vectors mapping

**Learning:** When evaluating character vectors for names in univariate time-series objects (e.g., `ts`), `names(x)` may return a vector of element names with length > 1. To avoid 'length > 1 in coercion to logical(1)' errors, safeguard `nzchar()` checks with a length validation like `length(series_name) == 1L`.

**Action:** Ensure length check is applied alongside `nzchar()` when working with character vectors like `names()` in univariate data structure checking or formatting logic.
