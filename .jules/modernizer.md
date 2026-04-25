## 2024-04-26 - Native pipe and magrittr `.` placeholder nuances in tests

**Learning:** When migrating from `%>%` to `|>` in older tests (like `test-visdat-internals.R`), the `.` placeholder is often used to refer back to the piped object (e.g. `names(.)[-length(.)]`). Because native pipes `|>` don't support the `.` placeholder in exactly the same way across all R versions without using `_` (which requires R >= 4.2.0), an anonymous function `(\(x) ...)(x)` or breaking it down into sequential steps is necessary to ensure tests run reliably and backwards compatibly. Additionally, simple boolean condition testing chains such as `x %>% is.na()` are better written using standard base syntax `is.na(x)` for clarity.

**Action:** Be mindful of `.` placeholders when applying native pipe refactors to legacy tests. Extract nested chains to anonymous functions `(\(x) function(x))` when encountering the `.` character if using standard function evaluation fails.
