# randomForest.R
# Name: Stephen Ling, Yifan Chen
# Email: jling9@wisc.edu, chen2336@wisc.edu
# README: this Rscript tests the acccuracy
#         of Random Forest
# Library: mlr3verse
# Input: data.csv
# Output: randomForest.txt

# preparation
rm(list=ls())
library(mlr3verse)

# read data
data <- read.csv("data.csv")
data$is_attributed <- as.factor(data$is_attributed)

task <- TaskClassif$new("stat479_rf", data , target = "is_attributed")


## randon forest
learner_rf <- lrn("classif.ranger")
learner_rf$param_set$ids(tags = "threads")
set_threads(learner_rf, n = 7)

set.seed(1) # set seed to make sure each algorithm get same train & test
train_set <- sample(task$row_ids, 0.001 * task$nrow)
test_set <- setdiff(task$row_ids, train_set)

learner_rf$train(task,row_ids = train_set)

pred_rf <- learner_rf$predict(task,row_ids = test_set)

cm <- pred_rf$confusion
accuracy <- (cm[2,2] / (cm[2,1] + cm[2,2]))

# write result
result <- toString(accuracy)
file.name <- file("randomForest.txt")
writeLines(result, file.name)
close(file.name)

# write.table(cm,"confusion_matrix_randomforest.txt",row.names = F,col.names = F)

