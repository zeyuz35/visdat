## 2024-05-24 - [tsbox coercion attribute loss]

**Learning:** When using `tsbox::ts_df()` to convert time-series objects (`ts`, `xts`, `zoo`) to `data.frame` for internal visualization rendering, any custom non-structural attributes (like `my_scale` or `transform` metadata) are silently stripped by the coercion process.

**Action:** When coercing rich time-series structures to standard data frames inside utility functions like `ts_to_df()`, always proactively capture the object's `attributes(x)` before transformation, and use `utils::modifyList()` to restore the custom non-structural attributes to the output before returning it, carefully avoiding writing back structural properties like `index` or `dim`.
