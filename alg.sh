#!/bin/bash

tar -xzf R412.tar.gz
tar -xzf packages.tar.gz

export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages

# run data splitting script
Rscript data.R train_sample

# run algorithm script
Rscript $1.R

rm train.csv
rm test.csv
