#!/usr/bin/env bash

if command -v acpi &>/dev/null
then
    capacity_pair="$(acpi -bi grep 'Battery 0' | grep -o '[0-9]\+ mAh' | xargs)"
    awk '{printf "%d/%d %s\n",$3,$1,$4,$6}' <<< "${capacity_pair}"
else
    echo "ACPI Unavailable"
fi
