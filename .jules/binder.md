## 2024-04-13 - Replace forcats with base factor

**Learning:** `forcats::fct_relevel` or `forcats::as_factor` in simple contexts can be fully replaced by base `factor()` with appropriate `levels` specifications. Using `levels = unique(stats::na.omit(x))` mimics `forcats::as_factor` correctly by not retaining NA in levels by default, unlike `unique()`. Releveling with an array of specific values placed first can be done with `c(order, setdiff(unique(stats::na.omit(x)), order))`.

**Action:** Replace `forcats` functions with their base R equivalents to remove a package dependency without changing the functionality when `forcats` features are not essential.
