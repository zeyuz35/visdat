## 2024-04-08 - tsbox::ts_df drops custom metadata attributes during time-series coercion

**Learning:** When using `tsbox::ts_df()` to convert time-series objects to data frames, custom non-structural metadata attributes (such as `scale` and `transform`) are silently stripped.

**Action:** Before converting a time-series object with `tsbox::ts_df()` or `coredata()`, explicitly capture its attributes, filter out structural keys (`dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`, `indexClass`, `tclass`, `tzone`), and re-apply the safe attributes to the resulting `data.frame` using `utils::modifyList()`.
