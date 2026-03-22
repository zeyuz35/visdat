## 2024-05-24 - tsbox strips attributes

**Learning:** `tsbox::ts_df()` strips custom attributes like `scale`, `center`, or user-defined attributes when converting time series objects (like `ts`, `xts`, `zoo`) to data frames.

**Action:** Whenever converting a time series object to a data.frame using `tsbox`, explicitly capture the original attributes and restore the non-structural ones to the resulting data.frame to prevent downstream metadata loss.
