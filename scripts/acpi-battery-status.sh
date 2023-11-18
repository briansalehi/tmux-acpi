#!/usr/bin/env bash

if command -v acpi &>/dev/null
then
    state="$(acpi -b | grep 'Battery 0')"
    state="${state#*: }"
    state="${state%%,*}"

    case "${state,,}" in
        "charging") echo "${state}" ;;
        "discharging") echo "${state}" ;;
        "not charging") echo "${state}" ;;
        *) echo "⚠️ No Battery"
    esac
else
    echo "ACPI Unavailable"
fi
