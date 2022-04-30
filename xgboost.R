# xgboost.R
# Name: Stephen Ling, Yifan Chen
# Email: jling9@wisc.edu, chen2336@wisc.edu
# README: this Rscript tests XGBoost acccuracy
# Library: mlr3verse
# Input: data
# Output: xgboost.txt

# preparation
rm(list=ls())
library(mlr3verse)

data <- read.csv("data.csv")
data$is_attributed <- as.factor(data$is_attributed)

task <- TaskClassif$new("stat479_xg", data , target = "is_attributed")


##XGboost
learner_xg <- lrn("classif.xgboost")
learner_xg$param_set$ids(tags = "threads")
set_threads(learner_xg, n = 7)

set.seed(1) # set seed to make sure each algorithm get same train & test
train_set <- sample(task$row_ids, 0.001 * task$nrow)
test_set <- setdiff(task$row_ids, train_set)

learner_xg$train(task,row_ids = train_set)

pred_xg <- learner_xg$predict(task,row_ids = test_set)

cm <- pred_xg$confusion
accuracy <- (cm[2,2] / (cm[2,1] + cm[2,2]))



# write result
result <- toString(accuracy)
file.name <- file("xgboost.txt")
writeLines(result, file.name)
close(file.name)

# write.table(cm,"confusion_matrix_xgboost.txt",row.names = F,col.names = F)
