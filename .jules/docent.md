## 2025-04-01 - S3 Method Extensions and @export Tags

**Learning:** In modern roxygen2 (>= 7.3.0), S3 method extensions (e.g., `vis_miss.ts`, `vis_miss.xts`) must explicitly include an `#' @export` or `#' @exportS3method` tag. Without these tags, the methods are not correctly registered in the NAMESPACE file, which can lead to dispatch failures and R CMD check warnings regarding S3 generic/method consistency.

**Action:** When adding or encountering S3 method extensions, always ensure they are preceded by `#' @export` so that `devtools::document()` correctly adds them as `S3method(...)` entries in the NAMESPACE file.
