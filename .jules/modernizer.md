## 2024-05-24 - Modernizing `tests/testthat/test-visdat-internals.R` with native pipes

**Learning:** When migrating magrittr pipes (`%>%`) to native pipes (`|>`) for R >= 4.1.0 compatibility, unroll pipe chains that use the `.` placeholder (e.g., `nrow(.)`) into sequential standard assignments or wrap the specific stage in an anonymous function (e.g., `(\(x) ...)(x)` or `(\(x) ...)()`), as the native pipe does not directly support `.` and the `_` placeholder is only available in R >= 4.2.0.

**Action:** Whenever converting `%>%` to `|>` in testing files, watch out for `.`, verify logic, and use regular assignment or lambda closures rather than blindly substituting `%>%` for `|>`. Also, ensure `Depends: R (>= 4.1.0)` is present in `DESCRIPTION`.
