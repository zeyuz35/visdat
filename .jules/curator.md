## 2024-05-06 - tsbox::ts_df drops structural and custom attributes

**Learning:** When using `tsbox::ts_df()` to convert a time-series object (`ts`, `xts`, `zoo`, etc.) into a data frame, custom attributes like `scale` and `transform` are dropped from the resulting data frame.

**Action:** Ensure that custom attributes are preserved before running `tsbox::ts_df()`, and restored onto the result afterwards, being careful to exclude structural attributes like `dim`, `tsp`, `class`, `row.names`, etc.
