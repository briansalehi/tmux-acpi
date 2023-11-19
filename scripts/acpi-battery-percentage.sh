#!/usr/bin/env bash

full_battery_icon="$1"
low_battery_icon="$2"

if command -v acpi &>/dev/null
then
    percentage="$(acpi -b | grep -o '[0-9]\+%')"

    [ "${#full_battery_icon}" -gt 1 ] && full_battery_icon+=" "
    [ "${#low_battery_icon}" -gt 1 ] && low_battery_icon+=" "

    if [ "${percentage%\%}" -gt 30 ]
    then
        echo "${low_battery_icon}${percentage}"
    else
        echo "${full_battery_icon}${percentage}"
    fi
else
    echo "ACPI Unavailable"
fi
