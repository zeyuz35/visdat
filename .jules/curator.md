## 2025-03-26 - ts_to_df attribute loss

**Learning:** Coercing time series objects to data frames using tsbox removes custom attributes like `scale` and `transform`.

**Action:** When restoring attributes from a time-series object to a coerced data.frame, explicitly filter out structural attributes (dim, dimnames, tsp, class, names, row.names, index) and merge the remaining ones into the output.
