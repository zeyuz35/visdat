## 2024-04-19 - [Native Pipe Transition]

**Learning:** In legacy test files (`test-visdat-internals.R`), magrittr pipe chains heavily utilize the `.` placeholder for dynamic evaluation (e.g. `nrow(.)` inside `dplyr::mutate` or `names(.)[-length(.)]` inside `tidyr::gather_`). The native pipe (`|>`) does not natively support the `.` pronoun in this manner without using anonymous function syntax.
**Action:** Unroll the pipe chains or wrap the specific stage in an anonymous function (`\(x)`) to explicitly bind the piped value when transitioning from magrittr pipes to native pipes in such cases.
