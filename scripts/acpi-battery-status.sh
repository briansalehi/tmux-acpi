#!/usr/bin/env bash

charging_icon="$1"
discharging_icon="$2"
not_charging_icon="$3"

if command -v acpi &>/dev/null
then
    state="$(acpi -b | grep 'Battery 0')"
    state="${state#*: }"
    state="${state%%,*}"

    case "${state,,}" in
        "charging") echo "${charging_icon}${state}" ;;
        "discharging") echo "${discharging_icon}${state}" ;;
        "not charging") echo "${not_charging_icon}${state}" ;;
        *) echo "⚠️ No Battery"
    esac
else
    echo "ACPI Unavailable"
fi
