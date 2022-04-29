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

# split train & test
split <- sample(c(rep(0, 0.2 * nrow(data)), rep(1, 0.8 * nrow(data))))
train <- data[split == 0, ]
test <- data[split == 1, ]

# oversampling (Package: imbalance)
train <- oversample(
  train,
  ratio = 0.8,
  method = "SMOTE",
  filtering = F,
  classAttr = "is_attributed")

# write csv files
write.name.train <- "train.csv"
write.csv(train, write.name.train, row.names=FALSE)
write.name.test <- "test.csv"
write.csv(test, write.name.test, row.names=FALSE)
