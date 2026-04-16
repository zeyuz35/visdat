## 2024-10-27 - Refactoring magrittr pipes with dots (.)

**Learning:** When modernizing R test suites and refactoring `magrittr` pipe chains (`%>%`) to native pipes (`|>`), the native pipe does not support using the placeholder (`.`) inside nested functions or operations like `names(.)[-length(.)]`. Instead of trying to force a native pipe solution using the `_` placeholder (which requires R >= 4.2.0 and has its own syntax constraints), unroll these specific chains into discrete assignment statements using a temporary variable. This approach guarantees exact compatibility with earlier R versions (R >= 4.1.0) and avoids complex syntax while maintaining clear logic.

**Action:** Whenever replacing `%>%` with `|>` in a chain that relies on `.`, evaluate if the operation can be simply extracted into a separate line of code before the pipeline, making the pipeline cleaner and eliminating the dependency on the dot entirely.
