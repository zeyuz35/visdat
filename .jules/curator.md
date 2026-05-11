## 2024-05-11 - Preserve custom attributes during `ts_to_df` conversion
**Learning:** `tsbox::ts_df` silently drops custom attributes and metadata. When doing data conversions for visualizing, restoring the non-structural attributes is necessary.
**Action:** Extract attributes using `attributes()`, identify and filter out core structural attributes (`"dim"`, `"dimnames"`, `"tsp"`, `"class"`, `"names"`, `"row.names"`, `"index"`, `"indexClass"`, `"tclass"`, `"tzone"`, `".indexCLASS"`, `".indexTZ"`), and explicitly re-assign the remaining ones to the new data frame.
