## 2024-05-18 - tsbox coercion silently strips attributes

**Learning:** `tsbox::ts_df()` conversion silently strips non-structural attributes (such as `scale`, `transform`) from time series objects like `xts` and `zoo`. If these outputs are coerced directly into data.frames, metadata is lost, which breaks operations relying on tracking those values.

**Action:** Capture `orig_attrs <- attributes(x)` before calling `tsbox::ts_df(x)`, explicitly filter out structural attributes `c("dim", "dimnames", "tsp", "class", "names", "row.names", "index", "indexClass", "tclass", "tzone")`, and merge the remaining custom attributes back using `utils::modifyList()` before returning the result.
