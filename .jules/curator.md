## 2024-05-24 - Data Integrity issues during tsbox conversions

**Learning:** When using tsbox::ts_df(), attributes (such as scale, custom_attr, etc.) present on the original time series object are lost since tsbox creates a new clean dataframe.
**Action:** Always capture non-structural attributes before calling ts_df() and restore them afterward to maintain data integrity, filtering out structural ones (e.g. dim, dimnames, tsp, class, names, row.names, index, etc.).
