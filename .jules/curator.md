## 2024-05-18 - Missing custom attributes after ts_to_df data.frame coercion

**Learning:** `tsbox::ts_df()` strips out non-structural custom metadata attributes (e.g. `scale`, `transform`) when it coerces time series objects (ts, xts, zoo) into data frames. Furthermore, evaluating `nzchar(names(x))` on univariate time-series objects can trigger a logical vector length error if `names(x)` returns a vector of length > 1 (which it can in modern R).

**Action:** Whenever coercing `ts`/`xts`/`zoo` objects into data frames inside internal helpers, capture the original attributes. After conversion, filter out structural attributes (`dim`, `tsp`, `class`, `names`, `row.names`, etc.) and merge the remaining custom attributes back onto the new data frame. Ensure that `nzchar()` checks on names are protected with `length(names) == 1L`.
