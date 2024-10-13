#!/usr/bin/env bash

if command -v acpi &>/dev/null
then
    state="$(acpi -b | grep 'Battery 0')"
    state="${state#*: }"
    state="${state%%,*}"
    percentage="$(acpi -b | grep -o '[0-9]\+%')"

    case "${state,,}" in
        "charging") echo "Charging" ;;
        "discharging") echo "Discharging" ;;
        "not charging") echo "Not Charging" ;;
        *)
            if [ ${percentage:-0} -eq 100 ]
            then
                echo "Not Charging"
            else
                echo "⚠️ No Battery"
            fi ;;
    esac
else
    echo "ACPI Unavailable"
fi
