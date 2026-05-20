## 2025-02-23 - Handle NA and length > 1 names in ts objects

**Learning:** When evaluating names of time-series objects (like `ts`, `mts`), `names(x)` or `colnames(x)` might return vectors of length > 1. Passing this to `nzchar()` produces a logical vector, triggering an error (`length > 1 in coercion to logical(1)`) in R >= 4.2.0. Additionally, `nzchar(NA)` evaluates to TRUE, potentially leading to incorrect or corrupted name assignments.

**Action:** Verify the length first (`if (length(x) > 1L) x <- NULL`) and safely evaluate single elements (`!is.null(x) && !is.na(x[1]) && nzchar(x[1])`) rather than blindly extracting the first element or directly passing the array to `nzchar`.
