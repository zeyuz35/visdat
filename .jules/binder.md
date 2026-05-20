## 2024-05-20 - Use base R setNames over purrr::set_names
**Learning:** purrr::set_names() can be replaced by stats::setNames() to reduce reliance on external packages in pipelines, since stats::setNames() integrates seamlessly with the native pipe.
**Action:** Replace purrr::set_names with stats::setNames.
