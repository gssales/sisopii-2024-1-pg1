#! /bin/bash

for i in $(seq 100); do 
	LD_LIBRARY_PATH=. time -p ./race_condition |& sed -Enr 's/real (.*)/\1/p' >> ./test_race_condition.txt; 
done;

awk '{ sum += $1 }; END { print sum/100 }' ./test_race_condition.txt

for i in $(seq 100); do 
	time -p ./thread_mutex |& sed -Enr 's/real (.*)/\1/p' >> ./test_thread_mutex.txt; 
done;
awk '{ sum += $1 }; END { print sum/100 }' ./test_thread_mutex.txt