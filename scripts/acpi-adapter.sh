#!/usr/bin/env bash

# icons can be customized by user
plugged_icon="$1"
unplugged_icon="$2"

[ "${plugged_icon}" == "-" ] && plugged_icon=""
[ "${unplugged_icon}" == "-" ] && unplugged_icon=""

if command -v acpi &>/dev/null
then
    status="$(acpi -a | grep 'Adapter 0' | awk '{print $3}')"

    # add space to avoid overlaping of wide character icons with values
    [ "${#plugged_icon}" -gt 1 ] && plugged_icon+=" "
    [ "${#unplugged_icon}" -gt 1 ] && unplugged_icon+=" "

    # icons chosen relative to adapter status
    if [ "${status}" == "off-line" ]
    then
        echo "${unplugged_icon}${status}"
    elif [ "${status}" == "on-line" ]
    then
        echo "${plugged_icon}${status}"
    else
        echo "Adapter Undetected"
    fi
fi
