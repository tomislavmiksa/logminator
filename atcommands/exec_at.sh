#!/usr/bin/env bash

MINT="/dev/ttyUSB3"

execAT () {
    cmd="echo $MCMD | atinout - $MINT -"
    output=$(eval "$cmd")
}