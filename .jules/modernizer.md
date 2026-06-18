## 2024-05-24 - Base R iterators
**Learning:** purrr::map_lgl can be slower and add dependency overhead compared to base R alternatives like vapply and lengths.
**Action:** Replaced purrr::map_lgl with base R equivalents lengths() and vapply() where appropriate.
