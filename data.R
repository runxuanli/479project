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

# split data randomly
set.seed(1)
total <- nrow(data)
n <- as.integer(total / 5)
t <- split(data, sample(rep(1:5, times=c(n,n,n,n,n))))
data.1 <- t$`1`
data.2 <- t$`2`
data.3 <- t$`3`
data.4 <- t$`4`
data.5 <- t$`5`

# write csv files
write.name <- "data1.csv"
write.csv(data.1, write.name, row.names=FALSE)
write.name <- "data2.csv"
write.csv(data.2, write.name, row.names=FALSE)
write.name <- "data3.csv"
write.csv(data.3, write.name, row.names=FALSE)
write.name <- "data4.csv"
write.csv(data.4, write.name, row.names=FALSE)
write.name <- "data5.csv"
write.csv(data.5, write.name, row.names=FALSE)

