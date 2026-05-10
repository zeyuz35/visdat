## 2024-06-25 - Replace ifelse with vectorized assignment in internals
**Learning:** `ifelse()` is highly inefficient for element-wise conditional replacements in R, particularly when dealing with vectors and lists (like in `visdat:::fingerprint`).
**Action:** Replaced `ifelse()` with pre-allocating a result vector and using vectorized subset assignment (e.g., `res[is.na(x)] <- NA`), significantly improving execution speed.
