## 2024-05-24 - Unused dependency
**Learning:** `stringr` was listed in `Suggests` in `DESCRIPTION` but never used anywhere in the codebase. Removing unused dependencies reduces bloat.
**Action:** Always check both `Imports` and `Suggests` for completely unused dependencies.
