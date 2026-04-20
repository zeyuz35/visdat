## 2024-04-19 - tsbox Coercion Attribute Loss

**Learning:** When coercing time-series objects (like `ts`, `xts`, `zoo`) to `data.frame` using `tsbox::ts_df()`, all non-structural attributes (like user-defined scaling metadata, transform histories, and custom strings) are silently stripped and lost.

**Action:** Always capture the original attributes before calling `tsbox::ts_df()` and manually restore non-structural attributes (filtering out structural ones like `dim`, `tsp`, `class`, `names`, `index`) to the resulting `data.frame` using `utils::modifyList()` to maintain data integrity.
