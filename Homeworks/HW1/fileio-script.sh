#! /bin/bash

echo "Hey, you are in $0, and about to test fileio"

THREADS=("16" "16" "16")
FILE_TOTAL_SIZES=("2G" "3G" "4G")
TEST_MODE=("rndrw" "rndrw" "rndrw")
TEST_RUNS=5
TEST_CASES=3

for ((i=0; i<$TEST_CASES;i++))
do
	echo "*****************************Starting ${i+1}st Test Case***************************************"
	for (( j=1; j <=$TEST_RUNS; j++ ))
	do
		echo "Running ${j}st run of Test Case ${i+1}"
		sysbench --threads=${THREADS[$i]} fileio --file-total-size=${FILE_TOTAL_SIZES[$i]} --file-test-mode=${TEST_MODE[i]} prepare
		sysbench --threads=${THREADS[$i]} fileio --file-total-size=${FILE_TOTAL_SIZES[$i]} --file-test-mode=${TEST_MODE[i]} run
		sysbench --threads=${THREADS[$i]} fileio --file-total-size=${FILE_TOTAL_SIZES[$i]} --file-test-mode=${TEST_MODE[i]} cleanup
		echo "Completed ${j}st run of Test Case ${i+1}"
	done
	echo "*****************************Completed ${i}st Test Case***************************************"
done
