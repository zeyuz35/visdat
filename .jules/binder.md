## 2024-05-18 - Removing forcats dependency

**Learning:** The `forcats` package was used solely for factor level preservation in `vis-binary.R`. It's a heavy dependency that can be effectively replaced with internal base R helper functions that implement `levels = unique(x[!is.na(x)])`.

**Action:** Before removing a package from `DESCRIPTION`, strictly verify via `grep` that *all* its functions are completely removed across the entire package source, tests, and vignettes, to avoid breaking namespace calls. Ensure all log and process files are properly removed from the workspace prior to code review or commits. When ignoring files for `R CMD build`, use PCRE instead of glob patterns in `.Rbuildignore` to prevent build failures.
