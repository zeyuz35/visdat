## 2024-05-24 - Optimize list checking with base R
**Learning:** Checking for list types using `purrr::map_lgl(data, is.list)` and empty elements with `purrr::map_lgl(x, ~ length(.x) == 0)` introduces overhead. Replacing them with base R equivalents `vapply(data, is.list, logical(1))` and `lengths(x) == 0L` is much faster.
**Action:** Replace `purrr::map_lgl` iterations with fast base R vectorization whenever iterating over lists for types or lengths.
