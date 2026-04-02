## 2024-05-24 - [ts_to_df drops custom attributes]

**Learning:** Internal coercion functions like `ts_to_df` utilizing `tsbox` silently strip custom metadata attributes (like `scale`, `transform`) during `data.frame` conversion, which corrupts data integrity for downstream methods expecting those attributes.

**Action:** Before structural transformations, explicitly capture original attributes (`attributes(X)`) and merge them into the resulting object, taking care to use `setdiff` to omit structural attributes like `class`, `dim`, `tsp` to prevent conflicts.
