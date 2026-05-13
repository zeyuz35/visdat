## 2024-05-14 - Fix logic error in `nzchar` usage for extracting time series names

**Learning:** `names()` on a univariate `ts` object created with a vector returns a vector of names of length equal to the vector, while on a matrix-backed `ts`, `colnames` works. Passing a vector of names to `nzchar()` produces a vector, which throws "'length > 1' in coercion to 'logical(1)'" when used inside an `if` condition in modern R.
**Action:** Extract the first element of `names(x)` or `colnames(x)` before evaluating `nzchar(x)` and use `!is.na()` instead of `!is.null()` and `nzchar()`.
