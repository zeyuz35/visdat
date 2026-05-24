## 2024-05-24 - Dependency reduction in visdat
**Learning:** `purrr::set_names` can often be directly replaced by `stats::setNames` within native pipe (`|>`) chains, which minimizes dependency on the `purrr` package for simple operations. `stats::setNames(object, nm)` correctly receives the object as the first argument from the pipe.
**Action:** Use `stats::setNames` instead of `purrr::set_names` whenever possible, and always clean up temporary scripts and logs (e.g., `install_log.txt`) from the file system to avoid polluting the git staging area before creating a PR.
