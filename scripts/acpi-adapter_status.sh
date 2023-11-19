#!/usr/bin/env bash

plugged_icon="$1"
unplugged_icon="$2"

if command -v acpi &>/dev/null
then
    status="$(acpi -a | grep 'Adapter 0' | awk '{print $3}')"

    [ "$(wc -c <<< "${plugged_icon}")" -gt 4 ] && plugged_icon+=" "

    if [ "${status}" == "off-line" ]
    then
        echo "${unplugged_icon}${status}"
    elif [ "${status}" == "on-line" ]
    then
        echo "${plugged_icon}${status}"
    else
        echo "Adapter Unavailable"
    fi
fi
