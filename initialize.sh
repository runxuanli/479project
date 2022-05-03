#!/bin/bash

mkdir -p log
mkdir -p error
mkdir -p output
mkdir -p dag

seq 1 5 > lists.txt

echo "logistic" >> files.txt
echo "naiveBayes" >> files.txt
echo "randomForest" >> files.txt

