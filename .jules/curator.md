## 2024-05-24 - tsbox::ts_df drops custom attributes

**Learning:** When coercing time-series objects (like `ts`, `xts`, `zoo`) to `data.frame` using `tsbox::ts_df()`, all custom attributes (e.g., `scale`, `transform`) are stripped. This results in silent loss of metadata that is crucial for downstream processes (like `backtransform`).

**Action:** Always capture `orig_attrs <- attributes(x)` before calling `tsbox::ts_df()`. Then, restore non-structural attributes to the resulting `data.frame` using `utils::modifyList(attributes(df), custom_attrs)`. Be sure to exclude structural attributes like `c("dim", "dimnames", "tsp", "class", "names", "row.names", "index", "indexClass", "tclass", "tzone")` to prevent corrupting the `data.frame` structure.
