#!/bin/bash

printf "ip, " > vars.txt
cat 1.txt >> vars.txt
rm 1.txt

printf "ip + app, " >> vars.txt
cat 2.txt >> vars.txt
rm 2.txt

printf "ip + app + device, " >> vars.txt
cat 3.txt >> vars.txt
rm 3.txt

printf "ip + app + device + os, " >> vars.txt
cat 4.txt >> vars.txt
rm 4.txt

printf "ip + app + device + os + channel, " >> vars.txt
cat 5.txt >> vars.txt
rm 5.txt

cat alg.txt > final.txt
cat vars.txt | sort -t',' -nrk 2 | head -n 1  >> final.txt

mv submitAllJobs.dag.* dag
rm data.csv

