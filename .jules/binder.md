## $(date +%Y-%m-%d) - Remove `forcats` dependency in favor of base R

**Learning:** `forcats::as_factor(x)` and `forcats::fct_relevel(x, order)` can be replaced with base R equivalents: `factor(x, levels = unique(stats::na.omit(x)))` and `factor(x, levels = if (is.null(order)) unique(stats::na.omit(x)) else c(order, setdiff(unique(stats::na.omit(x)), order)))`. This removes the need for the external `forcats` dependency.

**Action:** Use these base R `factor()` replacements instead of pulling in `forcats` for simple factor operations, enhancing package hygiene and minimizing dependencies.
