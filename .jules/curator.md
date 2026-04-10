## 2024-04-09 - Attributes stripped in tsbox::ts_df()

**Learning:** When using `tsbox::ts_df()` to coerce time-series objects (`ts`, `xts`, `zoo`, `mts`) to a `data.frame`, non-structural attributes (like scaling or custom transformation metadata) are silently stripped and lost.

**Action:** Capture attributes using `attributes(x)` before `ts_df()`, and explicitly restore them using `modifyList()` (filtering out structural attributes like `dim`, `tsp`, `names`, `index`, `class`) before returning the coerced data frame.
