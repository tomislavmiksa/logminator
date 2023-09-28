#!/usr/bin/env bash

source ./exec_at.sh

MCMD="AT+QCCID"

iccid=""
execAT
result=$(echo $output | awk '{print $NF}')
if [[ "$result" == *"OK"* ]]; then
    iccid=$( echo $output | awk '{print $3}' )
fi

echo $iccid