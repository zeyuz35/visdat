## 2024-05-04 - Replace purrr::set_names with stats::setNames

**Learning:** `stats::setNames` is the preferred base R alternative to `purrr::set_names` when using native pipes (`|>`), as it takes the object as its first argument and reduces dependency on `purrr`.

**Action:** Replace `purrr::set_names` with `stats::setNames` when maintaining or creating pipe chains.
