## 2024-04-24 - Replace purrr::set_names with stats::setNames

**Learning:** The purrr dependency can be slightly reduced by replacing `purrr::set_names` with base R `stats::setNames` inside dplyr/tidyr pipelines, as they are functionally equivalent for this use-case.

**Action:** Use `stats::setNames` instead of `purrr::set_names` to minimize dependency surface area.
