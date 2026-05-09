## 2024-05-10 - Replace purrr::set_names with stats::setNames
**Learning:** The base R equivalent of `purrr::set_names` is `stats::setNames`. `stats::setNames` integrates correctly with the `|>` native pipe when modifying a single object.
**Action:** Use `stats::setNames()` directly instead of `purrr::set_names()` in data processing pipelines to lower reliance on purrr dependencies.
