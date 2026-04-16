## 2024-05-16 - [tsbox::ts_df silently drops attributes]

**Learning:** When using `tsbox::ts_df()` to convert time-series objects to data frames, custom metadata and scaling/transformation attributes are silently stripped.

**Action:** Always capture original attributes before `tsbox::ts_df()` conversion and restore non-structural ones afterward (filtering out `dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`, `indexClass`, `tclass`, `tzone`) to maintain data integrity.
