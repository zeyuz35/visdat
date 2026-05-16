## 2024-05-24 - Safely evaluating names in time-series objects
**Learning:** `names()` or `colnames()` on time-series objects can return vectors > length 1, causing errors when passed to `nzchar()` in `if` conditions in R >= 4.2.0. Additionally `nzchar(NA)` is TRUE.
**Action:** Validate length with `if (length(x) > 1L) x <- NULL` and check validity with `!is.null(x) && !is.na(x[1]) && nzchar(x[1])` before assignment.
