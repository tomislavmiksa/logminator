#!/usr/bin/env bash

source ./exec_at.sh

# get pdp context configuration
MCMD="AT+CGDCONT?"
res=""
execAT
result=$(echo $output | awk '{print $NF}')
if [[ "$result" == *"OK"* ]]; then
    count=$( echo $output | tr " " "\n" | grep -c "+CGDCONT:" )
    # split array by the keyword +CGDCONT:
    arr=(${output//+CGDCONT:/ })
    # echo ${arr[@]}
fi
# remove 1st and last array element
unset arr[0]
unset arr[-1]

# get PDP context status
MCMD="AT+QIACT?"
res=""
execAT
result=$(echo $output | awk '{print $NF}')
if [[ "$result" == *"OK"* ]]; then
    # split array by the keyword +CGDCONT:
    arr2=(${output//+QIACT:/ })
fi
unset arr2[0]
unset arr2[-1]

# printout of the status
index=1
for element in "${arr[@]}"
do
    echo "  +CGDCONT : $element"
    echo "    +QIACT : ${arr2[$index]}"
    let index++
done