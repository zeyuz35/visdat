## 2024-05-18 - Replacing purrr::set_names with stats::setNames
**Learning:** `purrr::set_names()` creates an unnecessary dependency on the `purrr` package when native base R function `stats::setNames()` can be used instead without breaking native pipes (`|>` takes the object as the first argument).
**Action:** Replace `purrr::set_names()` with `stats::setNames()` in `R/data-vis-cor.R` and any other places, testing to ensure no regressions occur.
