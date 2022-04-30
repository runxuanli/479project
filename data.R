# data.R
# Name: Stephen Ling
# Email: jling9@wisc.edu

# README: this Rscript used on data frame
#         to split trainning and testing
#         data. Then, oversample the imbalanced
#         Training data.
# Library: imbalance (for oversampling)
# Input: data frame
# Output: train.csv (oversampled), test.csv

# preparation
rm(list=ls());
library(imbalance)

# take cmd arg
arg <- commandArgs(trailingOnly = T)
if (length(arg) != 1) {
  cat("usage: Rscript data.R <data>\n")
  quit()
}

path <- arg[1]
source.path <- paste0("./", path, ".csv")

# read data
data.temp <- read.csv(source.path)
index <- c(1,2,3,4,5,8)
data <- data.temp[,index]
data$is_attributed <- as.factor(data$is_attributed)


# oversampling (Package: imbalance)
data <- oversample(
  data,
  ratio = 0.8,
  method = "SMOTE",
  filtering = F,
  classAttr = "is_attributed")

# write csv files
write.name <- "data.csv"
write.csv(data, write.name, row.names=FALSE)

