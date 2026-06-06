## 2024-06-05 - Remove Unused Dependencies in DESCRIPTION

**Learning:** CI dependencies like `covr` are used by GitHub Actions (e.g., `test-coverage.yaml`) and should not be removed from `Suggests` even if they don't appear in the `R/` or `tests/` directories.
**Action:** Always check `.github/workflows` before removing a dependency from `Suggests`.
