#!/bin/bash

function get_response
{
        local ECHO
        # cat will read the response, then die on timeout
        cat <&5 >$TMP &
        echo "$1" >&5
        # wait for cat to die
        wait $!

        exec 6<$TMP
        read ECHO <&6
        if [ "$ECHO" != "$1" ]
        then
                exec 6<&-
                return 1
        fi

        read ECHO <&6
        read RESPONSE <&6
        exec 6<&-
        return 0
}


stty -F /dev/ttyUSB3 115200 -echo igncr -icanon onlcr ixon min 0 time 5

# Open modem on FD 5
exec 5<>/dev/ttyUSB3

get_response "AT" || echo "Bad response"
echo "Response was '${RESPONSE}'"       ;       cat $TMP

exec 5<&-

