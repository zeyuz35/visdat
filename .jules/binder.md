## 2024-04-10 - Dependency Removal Verification

**Learning:** Before removing a package from the `Imports` section of the `DESCRIPTION` file, exhaustively verify that it is no longer referenced anywhere in the codebase (including tests, examples, and revdep) using tools like `grep` to prevent breaking changes.

**Action:** Always run a codebase-wide grep (e.g., `git grep <pkg_name>`) before and after removing a dependency from `DESCRIPTION` to ensure no lingering references exist.
