## 2024-03-31 - ts_to_df strips custom attributes

**Learning:** `ts_to_df` uses `tsbox::ts_df` and creates a `data.frame` which strips non-structural attributes of the original object (like scale/transform). It also does not retain the original time series class since it only returns `data.frame`. This breaks functions that depend on the input object being preserved except for coredata extraction. Actually, since visdat functions output ggplot objects, it's expected that they convert input data internally. But if they strip attributes of the `ts` or `xts` object before manipulating or if they strip the time-series attributes it could be an issue. However, `ts_to_df` returns a plain `data.frame` with a custom `row_labels` attribute.

**Action:** Ensure that `ts_to_df` preserves all non-structural attributes of the original time series object by capturing `attributes(x)` before `tsbox::ts_df(x)` and copying the non-structural attributes to the returned `data.frame`.
