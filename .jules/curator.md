## 2024-03-27 - Attribute loss during time-series coercion

**Learning:** When using `tsbox::ts_df` inside `ts_to_df()` to convert `ts`, `xts`, `zoo`, and `mts` objects to a data.frame for internal plotting in visdat, custom metadata and data integrity attributes (like scale and transform factors) are silently dropped.

**Action:** Capture original attributes using `attributes()` before calling `tsbox::ts_df`, filter out structural and conflicting attributes like `dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`, and then attach the remaining preserved attributes to the generated `series_df` before returning it.
