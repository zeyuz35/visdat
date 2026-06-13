## 2024-05-24 - Unused dependency
**Learning:** `stringr` is listed in `Suggests` in the DESCRIPTION file, but after running `grep` over the codebase, I could not find any references to `stringr` or its `str_` functions in the source code, tests, vignettes, or GitHub Actions workflows. It is an unused dependency.
**Action:** Remove `stringr` from `Suggests` in the DESCRIPTION file to reduce package bloat.
