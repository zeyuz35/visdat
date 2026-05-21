## 2024-05-20 - Environment setup for Documentation Building

**Learning:** When rebuilding roxygen documentation, you must install the target package's dependencies (`Imports`, `Depends`). Sometimes system libraries like `libxml2-dev` are missing and must be installed via `apt-get` for packages like `xml2` to build successfully. Additionally, when using a custom `~/R/...` personal library in the sandbox, background processes (`... > log.txt 2>&1 &`) are essential to avoid session timeouts on large installs like `ggplot2` or `tidyverse`.

**Action:** Always verify necessary system libraries before attempting to install R documentation dependencies. Use background tasks with redirected output for large installation processes in the sandbox.
