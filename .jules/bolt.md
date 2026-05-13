## 2024-05-17 - Optimize ifelse calls in fingerprint

**Learning:** ifelse in R evaluates all paths and performs type checking, making it slow. Using vectorized pre-allocation (e.g., res <- rep(..., length(x))) and conditional subset replacement (e.g., res[is.na(x)] <- NA) is significantly faster. Furthermore, for lists, lengths(x) == 0L is much faster than purrr::map_lgl(x, ~ length(.x) == 0).

**Action:** Replace ifelse calls with pre-allocation and subset replacement when possible, especially in internal functions called frequently like fingerprint. Avoid purrr mapping functions for simple element-wise operations like checking list lengths, preferring base R vectorized functions like lengths.
