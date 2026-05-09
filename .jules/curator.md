## 2024-05-10 - Preserving Custom Metadata and Preventing Length > 1 Errors in tsbox coercion

**Learning:** When using `tsbox::ts_df()` to convert time-series objects to data frames, custom metadata and scaling/transformation attributes are silently stripped. Additionally, evaluating character vectors for names in univariate time-series objects using `nzchar(names(x))` may return an error 'length > 1 in coercion to logical(1)' if `names(x)` has a length > 1.

**Action:** Always capture original attributes before `tsbox::ts_df()` conversion and restore non-structural ones afterward to maintain data integrity. Guard `nzchar()` checks with `length(name) == 1L` to prevent evaluation errors.
