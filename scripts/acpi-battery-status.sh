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
       "full") echo "Fully Charged" ;;
        *)
            if [ "${percentage:-0}" == "100%" ]
            then
                echo "Fully Charged"
            else
                echo "⚠️ No Battery"
            fi ;;
    esac
else
    echo "ACPI Unavailable"
fi
