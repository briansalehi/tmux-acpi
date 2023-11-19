#!/usr/bin/env bash

health_icon="$1"

if command -v acpi &>/dev/null
then
    health_output="$(acpi -bi | grep 'Battery 0' | grep -o '= [0-9]\+')"
    [ "$(wc -c <<< "${health_icon}")" -gt 4 ] && health_icon+=" "
    echo "${health_icon}${health_output/= /}%"
else
    echo "ACPI Unavailable"
fi
