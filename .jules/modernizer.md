## 2024-05-24 - Unrolling magrittr pipes with `.` placeholders

**Learning:** When migrating magrittr pipes (`%>%`) to native pipes (`|>`) for R >= 4.1.0 compatibility, you cannot directly convert pipes that use the `.` placeholder (e.g., `nrow(.)` or `names(.)[-length(.)]`). The native pipe only supports passing the LHS to the first argument of the RHS. While R 4.2+ added the `_` placeholder, it has limitations.

**Action:** Identify magrittr pipe chains using the `.` placeholder during modernization and unroll them into sequential, standard variable assignments (e.g., `test_old_gather <- dplyr::mutate(typical_data, rows = seq_len(nrow(typical_data)))`) to safely remove the `%>%` dependency while preserving identical behavior and broad compatibility.
