## 2024-05-06 - Prevent attribute loss during tsbox::ts_df conversion

**Learning:** When converting time-series objects (`ts`, `xts`, `zoo`) to a `data.frame` using `tsbox::ts_df()`, custom metadata attributes (like `scale`, `transform`) are silently stripped. This happens because the coercion to a `data.frame` creates a new object without copying over non-standard attributes.

**Action:** Before invoking `tsbox::ts_df()` (or similar coercions that create fresh objects), proactively capture the original attributes using `original_attrs <- attributes(x)`. After the coercion, systematically filter out structural attributes inherent to the new class (e.g., `dim`, `tsp`, `index`, `class`) and re-apply the custom metadata to the result using `utils::modifyList()`. This preserves data integrity across object types.
