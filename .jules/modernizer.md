## 2024-05-24 - Unrolling magrittr `.` placeholder for native pipe

**Learning:** When migrating magrittr pipes (`%>%`) to native R pipes (`|>`), the native pipe does not fully support the dot `.` placeholder in the same way (R >= 4.2 supports `_` for named arguments, but it's not a universal replacement). Pipe chains that rely on `.` for multiple operations or referencing the current object state (e.g., `nrow(.)`, `names(.)[-length(.)]`) must be explicitly unrolled into sequential standard variable assignments to safely convert them.

**Action:** Always scan `%>%` chains for the `.` placeholder. When found, break the chain, assign the intermediate result to a variable (e.g., `test_old_gather <- ...`), and use that variable explicitly in the subsequent operations instead of attempting to force native pipe placeholders.
