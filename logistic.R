# logistic.R
# Name: Stephen Ling, Yifan Chen,Renee Li
# Email: jling9@wisc.edu, chen2336@wisc.edu, rli366@wisc.edu
# README: this Rscript tests the acccuracy
#         of Logistic Regression.
# Library: mlr3verse
# Input: data.csv
# Output: logistic.txt

# preparation
rm(list=ls())
library(mlr3verse)

data <- read.csv("data.csv")
data$is_attributed <- as.factor(data$is_attributed)

task <- TaskClassif$new("stat479_logi", data , target = "is_attributed")

learner_logi <- lrn("classif.log_reg")
learner_logi$param_set$ids(tags = "threads")
set_threads(learner_logi, n = 7)

set.seed(1) # set seed to make sure each algorithm get same train & test
train_set <- sample(task$row_ids, 0.001 * task$nrow)
test_set <- setdiff(task$row_ids, train_set)

learner_logi$train(task,row_ids = train_set)

pred_logi <- learner_logi$predict(task,row_ids = test_set)

cm <- pred_logi$confusion
accuracy <- (cm[2,2] / (cm[2,1] + cm[2,2]))


# write result
result <- toString(accuracy)
file.name <- file("logistic.txt")
writeLines(result, file.name)
close(file.name)

# write.table(cm,"confusion_matrix_logistic.txt",row.names = F,col.names = F)

