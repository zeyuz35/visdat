## 2024-04-15 - [tsbox::ts_df drops non-structural metadata and ts subsetting creates names arrays]

**Learning:** When using `tsbox::ts_df` or similar coercion functions to extract core data from time series objects, custom non-structural attributes (like `scale`, `transform`) are lost. Additionally, some `ts` objects when subsetted can return a `names()` vector with a length matching the elements (e.g. `letters[1:10]`), causing logical evaluation failures in `if (nzchar(name))` when the length exceeds 1.

**Action:** Always capture non-structural attributes using `attributes(x)` before calling extraction functions like `ts_df` and selectively restore them (filtering out structural items like `dim`, `class`, `tsp`) using `utils::modifyList()`. Always guard single-name extraction logic with explicit length checks like `length(names) == 1L`.
