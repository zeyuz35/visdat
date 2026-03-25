library(tsbox)
library(zoo)
library(cli)

source("R/internals.R")

# Create mock data
x <- zoo(1:10, as.Date("2000-01-01") + 0:9)
attr(x, "scale") <- 2
attr(x, "transform") <- "log"

cat("\n--- Testing ts_to_df ---\n")
print(str(x))
y <- ts_to_df(x)
print(str(y))
