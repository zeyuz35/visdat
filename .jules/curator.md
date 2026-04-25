## 2024-05-24 - ts_to_df Attribute Loss and Names Coercion

**Learning:** `tsbox::ts_df()` conversion silently strips custom metadata and scaling attributes from time-series inputs. Furthermore, `names(x)` on a univariate `ts` object can return a character vector of length > 1 (one name per observation), which causes a 'length > 1 in coercion to logical(1)' error when passed to `nzchar()`.

**Action:** Always capture `attributes(x)` before `tsbox::ts_df()` and restore non-structural attributes afterward. Safeguard `nzchar()` checks on series names with `length(series_name) == 1L`.
