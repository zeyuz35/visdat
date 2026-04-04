## 2024-05-18 - ts_to_df strips custom attributes

**Learning:** Internal coercion function `ts_to_df()` via `tsbox::ts_df()` strips custom scaling and transformation metadata attached to time-series objects, violating the Curator mandate.

**Action:** Capture `attributes(x)` before conversion and restore non-structural ones to the resulting `data.frame` via `modifyList()`.
