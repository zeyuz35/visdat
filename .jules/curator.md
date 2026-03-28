## 2024-05-24 - [ts_to_df Coercion Attribute Loss]

**Learning:** Coercing time series objects like `xts` and `zoo` to a `data.frame` via `tsbox::ts_df` inherently strips custom attributes (such as `scale` and `transform` metadata) because the underlying data structure loses its original container.

**Action:** When performing `ts` to `df` coercion for plotting operations, proactively extract the input's attributes before coercing, explicitly exclude structure-specific attributes (e.g., `dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`), and restore the remaining custom attributes to the coerced `data.frame` using `utils::modifyList()`.
