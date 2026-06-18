## 2024-06-18 - Remove unused stringr dependency
**Learning:** The `stringr` package is listed in `DESCRIPTION` as a dependency but isn't actually used anywhere in the `R/` or `tests/` codebase. The only references are in git history and the `DESCRIPTION` file itself.
**Action:** Remove `stringr` from `DESCRIPTION` to reduce dependency bloat.
