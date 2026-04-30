## 2024-05-18 - tsbox::ts_df() strips custom attributes

**Learning:** When coercing time-series objects to `data.frame` using `tsbox::ts_df()`, custom attributes (like `scale` or `transform` metadata) are silently stripped. Additionally, `names(x)` on `ts` objects can return character vectors of length > 1, causing failures in strict validation checks like `nzchar()` inside `if` statements.

**Action:** Always capture `original_attrs <- attributes(x)` prior to coercion. After coercion, restore the custom attributes by filtering out structural attributes (`dim`, `dimnames`, `tsp`, `class`, `names`, `row.names`, `index`, `indexClass`, `tclass`, `tzone`, `.indexCLASS`, `.indexTZ`) and using `utils::modifyList(attributes(df), custom_attrs)`. Validate `names()` outputs with `length(n) == 1L` before passing to scalar validation functions like `nzchar()`.
