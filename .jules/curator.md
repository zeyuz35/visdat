## $(date +%Y-%m-%d) - Prevent silent attribute loss during ts_to_df conversion

**Learning:** When using `tsbox::ts_df()` to convert time-series objects to a dataframe within internal functions (e.g., `ts_to_df()`), custom metadata attributes like `scale` and `transform` are completely stripped, leading to silent attribute loss.

**Action:** Always capture the original object attributes with `attributes(x)` before calling the conversion functions. After conversion, ensure that non-structural attributes (excluding `class`, `dim`, `names`, `row.names`, `tsp`, `index`, etc.) are merged into the new output object using `utils::modifyList()` to preserve custom metadata.
