## 2024-04-01 - [Restoring Attributes in ts_to_df()]

**Learning:** Structural attributes (e.g., dim, dimnames, tsp, class, names, row.names, index, indexClass, tclass, tzone) must be explicitly filtered out when restoring attributes to a coerced data.frame, preventing structure conflicts while preserving custom metadata like scale and transform.

**Action:** When extracting data via coredata() or similar coercion utilities, capture original_attrs <- attributes(newdata) first, perform computations, then restore filtered attributes back onto the result object.
