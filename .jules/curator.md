## 2024-03-24 - Attribute Loss in `ts_to_df` Conversion

**Learning:** The internal utility `ts_to_df` used to convert various time-series objects into data frames for visualization functions was stripping all custom attributes attached to the original object (such as `scale`, `transform`). This silent loss of metadata corrupts data integrity when those dataframes are further processed or passed into visualization layers that might expect or rely on those attributes.

**Action:** Ensure `ts_to_df` captures the original attributes `original_attrs <- attributes(x)` and safely restores non-structural attributes back to the resulting data frame using `modifyList` before returning.
