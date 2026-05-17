## 2024-05-18 - Safe Name Evaluation for Time Series

**Learning:** `names(x)` or `colnames(x)` on time-series objects can return a vector of length > 1. In R >= 4.2.0, passing a length > 1 logical vector to `if()` throws an error. Additionally, `nzchar(NA)` returns `TRUE`.
**Action:** Verify vector length before using `nzchar` in `if` conditions (`if (length(x) > 1L) x <- NULL`) and explicitly check for `!is.na(x[1])` and `nzchar(x[1])`.
