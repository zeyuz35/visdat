## 2024-04-08 - tsbox::ts_df() Silent Attribute Loss

**Learning:** When coercing time-series objects (`ts`, `xts`, etc.) to `data.frame` using `tsbox::ts_df()`, custom non-structural attributes (like `scale` or `transform` metadata) are silently stripped.

**Action:** Always capture all original attributes using `attributes(X)` before using `tsbox::ts_df()`, and explicitly restore non-structural attributes (filtering out structural ones like `dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`, `indexClass`, `tclass`, `tzone`) to the output `data.frame` using `utils::modifyList()`.
