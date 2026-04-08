# agents.md

This repository is a fork of the `visdat` R package for visualising data. The purpose is to extend the original package for seamless time series data support (ts, mts, zoo, xts, tsibble).

---

## Bug Dashboard

**Last Updated:** 2026-04-08  
**Review Status:** COMPLETED  
**Fix Status:** All 10 fixable bugs resolved (Bug #8 informational only)

---

### High Severity (5 bugs) - ALL FIXED

| # | File:Line | Issue | Status |
|---|-----------|-------|--------|
| 1 | `R/vis-compare.R:159` | String comparison bug | FIXED |
| 2 | `R/vis-expect.R:76-77` | Label swap | FIXED |
| 3 | `R/internals.R:581` | Invalid ggplot2 | FIXED |
| 4 | `R/internals.R:79-89` | Column order mismatch | NO-OP (not a bug) |
| 5 | `R/vis-histogram.R:17` | Missing S3 dispatch | FIXED |

---

### Medium Severity (3 bugs) - ALL FIXED

| # | File:Line | Issue | Status |
|---|-----------|-------|--------|
| 6 | `R/internals.R:408` | Error vs warning | FIXED |
| 7 | `R/vis-compare.R:26` | Incomplete transpose | NO-OP (not a bug) |
| 8 | `R/data-vis-*.R` | Missing time series methods | INFORMATIONAL |

---

### Low Severity (3 bugs) - ALL FIXED

| # | File:Line | Issue | Status |
|---|-----------|-------|--------|
| 9 | `R/internals.R:330` | Wrong function in error | FIXED |
| 10 | `R/internals.R:305` | NA for NaN | FIXED |
| 11 | `R/internals.R:464-469` | Duplicate entries | FIXED |

---

## Time Series Feature Work

**Y-axis ordering for time series plots** (COMPLETED 2026-04-08)

- **Requirement:** Oldest time should appear at TOP of y-axis, newest at BOTTOM (consistent with R's `print.ts()`)
- **Implementation:** `vis_add_time_geom()` in `R/internals.R` negates time values (`-as.numeric(row_labels)`)
- **Y-axis labels:** Formatted as year only (e.g., `1980`) via `format(as.Date(-x, origin = "1970-01-01"), "%Y")`
- **Transpose support:** `vis_add_time_geom()` swaps aesthetics (x=time, y=variable) when `transpose=TRUE`, avoiding coord_flip issues with discrete/discrete scale conflicts
- **Time axis labels:** `vis_add_time_coords()` adds appropriate continuous scale (x for transposed, y for non-transposed)
- **Test file:** `tests/testthat/test-vis-miss-timeseries.R` — 10/10 tests passing
- **Test approach:** Verifies `ggplot_build(p)$layout$panel_params[[1]]$y.range[2] > y.range[1]` for non-transposed, `x.label = "Time"` for transposed

**Key implementation detail:** Because time is negated, in the internal scale:
- `y.range[1]` = more negative = older time (at visual TOP)
- `y.range[2]` = less negative = newer time (at visual BOTTOM)
- Correct ordering = `y.range[2] > y.range[1]`

---

## Project Structure

```
visdat/
|-- R/                    # Core package functions (17 files)
|   |-- vis-*.R           # Main vis_* user-facing functions (S3 generics + methods)
|   |-- internals.R       # Internal helpers (fingerprint, plotting, validation)
|   |-- abbreviate.R      # Class label abbreviation helper
|   |-- data-*.R          # Bundled example data definitions
|-- tests/testthat/       # Unit tests (testthat edition 3)
|   |-- test-*.R          # Test files matching R/ function names
|-- smoke/                # Smoke test scripts (local dev only)
|-- docs/                 # pkgdown documentation site
```

---

## Skills Reference

Detailed guidance is provided by skills. Load with `/skill <name>`.

| Stage | Skill | Purpose |
|-------|-------|---------|
| Universal | `r-style-modernizer` | Formatting, pipes, iterators, messaging, returns |
| Universal | `r-environment-compliance` | ASCII-only, professional tone, conventional commits |
| Analysis | `r-analysis-workflow` | Script organization, exploratory data/visualization |
| Development | `r-package-dev` | Package structure, S3 dispatch, documentation, testing |
| Development | `r-time-series-consistency` | Class consistency across ts, xts, zoo |
| Development | `rcpp-armadillo-expert` | RcppArmadillo integration |
| Review | `r-quality-gate` | Build verification, security, artifact hygiene |

---

## S3 Method Pattern

Every `vis_*` function follows this structure:

1. Generic: `vis_name <- function(x, ...) UseMethod("vis_name")`
2. Primary method: `vis_name.data.frame` (main implementation)
3. Time series methods: `vis_name.ts`, `vis_name.mts`, `vis_name.zoo`, `vis_name.xts`, `vis_name.tbl_ts`, `vis_name.tsibble`
4. Default method: `vis_name.default` with `tsbox::ts_boxable()` fallback
5. All non-data.frame methods convert via `ts_to_df()` then dispatch to `.data.frame` method

**Time Series Conversion:** `ts_to_df()` in `R/internals.R` handles conversion. Stores time index as `row_labels` attribute.

---

## Commands

```bash
# Build package
R CMD build .

# Check package
R CMD check --as-cran visdat_*.tar.gz

# Run tests
Rscript -e "devtools::test()"

# Build documentation
Rscript -e "devtools::document()"

# Build pkgdown site
Rscript -e "pkgdown::build_site()"

# Run smoke tests
for f in smoke/*.R; do Rscript "$f"; done
```

---

## CI/CD & Automation

| Workflow | Purpose |
|----------|---------|
| `R-CMD-check.yaml` | R CMD check across OS/R matrix |
| `test-coverage.yaml` | covr::codecov coverage upload |
| `pkgdown.yaml` | pkgdown site build/deploy |
| `pr-commands.yaml` | `/document` and `/style` PR commands |

### PR Commands
- `/document` — runs `roxygen2::roxygenise()`
- `/style` — runs `styler::style_pkg()`

### Build Exclusions
- `.Rbuildignore` excludes: .github, pkgdown, docs, paper, README-figs, data-raw, revdep
- `.gitignore` excludes: .Rproj.user, docs, LLM/, scratch/, smoke/, *.code-workspace

---

## Testing Conventions

| Type | Tool | Notes |
|------|------|-------|
| Visual regression | `vdiffr::expect_doppelganger()` | Snapshots in `_snaps/`, skip on cran/ci |
| Text/data snapshots | `testthat::expect_snapshot()` | For tibble/text outputs |
| Error snapshots | `expect_snapshot(error = TRUE)` | For expected errors |
| Unit assertions | `expect_equal()`, `expect_true()` | Standard assertions |
| S3 dispatch | Test with `AirPassengers` (ts) | Verify method dispatch |

### File Naming
- Test files: `tests/testthat/test-<feature>.R` (mirror R/ file naming)
- Visual snapshots: `tests/testthat/_snaps/`

---

## Where to Look

| Task | Location | Notes |
|------|----------|-------|
| Add new vis_* function | R/vis-<name>.R | Follow S3 generic + method pattern |
| Add internal helper | R/internals.R | Or create new R/ file if large |
| Add test | tests/testthat/test-<name>.R | Mirror R/ file naming |
| Add time series test | tests/testthat/test-vis-miss-timeseries.R | Y-axis ordering tests |
| Add visual snapshot test | tests/testthat/ + _snaps/ | Use vdiffr |
| Smoke test | smoke/smoke_vis_<name>.R | Quick sanity check (local only) |
| Example data | R/data-*.R | Define with `data()` |
| Package docs | vignettes/, README.Rmd | pkgdown builds to docs/ |
