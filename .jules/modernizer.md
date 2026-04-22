## 2026-04-21 - tests magrittr pipe conversions

**Learning:** In test files, magrittr pipes with '.' placeholders need to be unrolled or wrapped in anonymous functions for correct conversion to native R '|>' pipe since native pipes do not support the '.' placeholder.

**Action:** Use '(\(x) func(x, ...))()' wrapper around function steps containing '.' or replace '.' with the variable being piped directly if practical, being mindful of nested scopes.
