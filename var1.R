# var1.R
# Name: Stephen Ling
# Email: jling9@wisc.edu

# README: this Rscript tests 1 var
# Input: train.csv, test.csv
# Output: 1.txt

# preparation
rm(list=ls())
library(mlr3verse)

# take cmd arg
algorithm <- readLines("alg.txt")
data.temp <- read.csv("data.csv")
data.temp$is_attributed <- as.factor(data.temp$is_attributed)

var.comb <- function(alg, t) {
  # prepare data
  i <- c(1, 6)
  data <- t[,i]
  
  if (alg == "logistic") {
    
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
    score <- (cm[2,2] / (cm[2,1] + cm[2,2]))
    
    return(score);
  }
  
  if (alg == "naiveBayes") {
    
    task <- TaskClassif$new("stat479_nb", data , target = "is_attributed")
    
    learner_nb <- lrn("classif.naive_bayes")
    learner_nb$param_set$ids(tags = "threads")
    set_threads(learner_nb, n = 7)
    
    set.seed(1) # set seed to make sure each algorithm get same train & test
    train_set <- sample(task$row_ids, 0.001 * task$nrow)
    test_set <- setdiff(task$row_ids, train_set)
    
    learner_nb$train(task,row_ids = train_set)
    
    pred_nb <- learner_nb$predict(task,row_ids = test_set)
    
    cm <- pred_nb$confusion
    score <- (cm[2,2] / (cm[2,1] + cm[2,2]))
    
    return(score);
  }
  
  if (alg == "xgboost") {
    
    task <- TaskClassif$new("stat479_xg", data , target = "is_attributed")
    
    learner_xg <- lrn("classif.xgboost")
    learner_xg$param_set$ids(tags = "threads")
    set_threads(learner_xg, n = 7)
    
    set.seed(1) # set seed to make sure each algorithm get same train & test
    train_set <- sample(task$row_ids, 0.001 * task$nrow)
    test_set <- setdiff(task$row_ids, train_set)
    
    learner_xg$train(task,row_ids = train_set)
    
    pred_xg <- learner_xg$predict(task,row_ids = test_set)
    
    cm <- pred_xg$confusion
    score <- (cm[2,2] / (cm[2,1] + cm[2,2]))
    
    return(score);
  }
  
  if (alg == "randomForest") {
    
    task <- TaskClassif$new("stat479_rf", data , target = "is_attributed")
    
    learner_rf <- lrn("classif.ranger")
    learner_rf$param_set$ids(tags = "threads")
    set_threads(learner_rf, n = 7)
    
    set.seed(1) # set seed to make sure each algorithm get same train & test
    train_set <- sample(task$row_ids, 0.001 * task$nrow)
    test_set <- setdiff(task$row_ids, train_set)
    
    learner_rf$train(task,row_ids = train_set)
    
    pred_rf <- learner_rf$predict(task,row_ids = test_set)
    
    cm <- pred_rf$confusion
    score <- (cm[2,2] / (cm[2,1] + cm[2,2]))
    
    return(score);
  }
}

accuracy <- var.comb(algorithm, data.temp)
result <- toString(accuracy)

file.name <- file("1.txt")
writeLines(result, file.name)
close(file.name)


