## 2024-04-11 - tsbox strips original attributes during coercion

**Learning:** When using `tsbox::ts_df()` to convert time-series objects (`ts`, `xts`, `zoo`) to `data.frame` for internal processing, custom metadata attributes such as `scale` and `transform` are completely stripped from the resulting object.

**Action:** Always capture the original attributes before calling `ts_to_df()` and safely restore the non-structural metadata using `modifyList` to the output object to prevent silent metadata loss.
