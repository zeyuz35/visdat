## 2024-05-08 - Convert purrr lambdas to native anonymous functions

**Learning:** Purrr formula lambdas (e.g. `~f(.x)`) can be seamlessly modernized to native R anonymous functions (e.g. `\(x) f(x)`) to reduce dependency overhead and improve clarity, as they are syntactically and functionally equivalent in modern R (>= 4.1.0). However, explicit formulas parsed by `vis_expect` must remain untouched to avoid breaking test logic.

**Action:** When migrating `map` and `rename_with` calls, replace `~` lambdas with `\(var)` syntax, but always distinguish them from literal formula parameters required by other internal package functions.
