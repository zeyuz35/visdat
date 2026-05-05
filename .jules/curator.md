# Curator Journal

## 2024-05-27 - `tsbox::ts_df()` strips custom metadata attributes

**Learning:** When using `tsbox::ts_df()` to convert time-series objects (`ts`, `xts`, `zoo`) to `data.frame`, custom metadata and scaling/transformation attributes are silently stripped. The structural coercion process does not natively preserve user-defined or class-specific non-structural attributes.

**Action:** Always capture original attributes before invoking `tsbox::ts_df()`, and explicitly restore non-structural attributes to the resulting `data.frame` using `modifyList()` after identifying and filtering out structural attributes (`dim`, `tsp`, `class`, `index`, etc.).
