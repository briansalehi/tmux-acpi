#!/usr/bin/env bash

if command -v acpi &>/dev/null
then
    state="$(acpi -b | grep 'Battery 0')"
    state="${state#*: }"
    state="${state%%,*}"

    case "${state,,}" in
        "charging") echo "Charging" ;;
        "discharging") echo "Discharging" ;;
        "not charging") echo "Not Charging" ;;
        *) echo "⚠️ No Battery"
    esac
else
    echo "ACPI Unavailable"
fi
