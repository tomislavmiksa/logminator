#!/usr/bin/env bash

source ./exec_at.sh

MCMD="AT+CIMI"

imsi=""
execAT
result=$(echo $output | awk '{print $NF}')
if [[ "$result" == *"OK"* ]]; then
    imsi=$( echo $output | awk '{print $2}' )
fi

echo $imsi