## 2024-05-10 - [Data Integrity & Type Stability]
**Learning:** tsbox::ts_df() strips custom metadata from time-series objects and names(x) on a ts object can return length > 1
**Action:** explicitly capture and restore non-structural attributes during ts -> df conversion and use length(x) == 1L before nzchar()
