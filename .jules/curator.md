## 2024-03-26 - Restoring Attributes in Time Series to DataFrame Conversion

**Learning:** When using `tsbox::ts_df` to coerce time-series objects to data frames, custom non-structural attributes (like `scale` or `transform`) attached to the original object are silently stripped. Using `utils::modifyList()` provides a safe way to merge restored original attributes back into the attributes of the new data frame, avoiding issues where you completely overwrite necessary structural attributes of the new data frame (like `names` or `row.names`).

**Action:** Always capture `attributes(x)` before coercing `x` to a data frame, and then restore them by appending via `utils::modifyList(attributes(new_df), attrs_to_restore)` while explicitly filtering out structural attributes (`dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`) from the original object to prevent conflicts.
