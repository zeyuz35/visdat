## 2024-04-27 - Preserve custom attributes in tsbox conversion

**Learning:** Using `tsbox::ts_df()` to convert time-series objects to data frames silently strips custom metadata and scaling/transformation attributes.

**Action:** Always capture original attributes before conversion and restore non-structural ones afterward to maintain data integrity.
