## 2024-04-21 - Remove forcats dependency

**Learning:** `forcats` was used for trivial factor leveling and reordering in `vis_binary.R`. It was possible to create a base R replacement that correctly preserves the levels by explicitly extracting them. The base R refactor required internal helper functions `vis_as_factor` and `vis_fct_relevel` to maintain readability within a dense dplyr pipeline.

**Action:** Before removing an entire dependency, check how many times the function is used and whether a direct base R equivalent is cleaner, or if a custom internal helper should be written.
