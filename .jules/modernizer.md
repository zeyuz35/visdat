## 2023-10-27 - Modernizing map_lgl to vapply in internals.R
**Learning:** `purrr::map_lgl` and `purrr::map_chr` add dependency overhead where base R alternatives like `vapply` perform better and reduce reliance on `purrr`.
**Action:** Replace `purrr::map_lgl` and `purrr::map_chr` with base R alternatives like `vapply(x, check_func, logical(1))` and `vapply(x, check_func, character(1))`.
