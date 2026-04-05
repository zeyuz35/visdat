## 2024-04-06 - ts_df attribute stripping

**Learning:** When using `tsbox::ts_df()` to convert time-series objects to data frames, custom metadata and scaling/transformation attributes are silently stripped.

**Action:** Always capture original attributes before conversion (`original_attrs <- attributes(x)`) and restore non-structural ones afterward using `utils::modifyList()` to maintain data integrity.
