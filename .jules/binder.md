## 2024-05-27 - Replace purrr::set_names with stats::setNames
**Learning:** Using `purrr::set_names()` adds unnecessary dependency overhead when working with data manipulation pipelines, as it can be entirely replaced by `stats::setNames()`. Base R `stats::setNames()` works perfectly with the native pipe `|>` since it takes the object as its first argument.
**Action:** Always prefer `stats::setNames()` over `purrr::set_names()` or `names(x) <-` when modifying names at the end of native pipe chains to maintain dependency hygiene and smooth chain flow.
