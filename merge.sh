#!/bin/bash

printf "logistic," >> result_alg.txt
cat logistic.txt >> result_alg.txt
rm logistic.txt

printf "naiveBayes," >> result_alg.txt
cat naiveBayes.txt >> result_alg.txt
rm naiveBayes.txt


printf "randomForest," >> result_alg.txt
cat randomForest.txt >> result_alg.txt
rm randomForest.txt

cat result_alg.txt | sort -t',' -nrk 2 | head -n 1 | cut -d',' -f1 > alg.txt

