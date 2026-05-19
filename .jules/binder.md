## 2024-05-19 - Removed purrr set_names dependency from data-vis-cor.R
**Learning:** `purrr::set_names` can often be directly replaced by `stats::setNames` to reduce the dependency footprint of small R scripts.
**Action:** Always verify if a native R function (like `stats::setNames`) can replace a small dependency call (like `purrr::set_names`) cleanly without breaking pipe flows or namespacing.
