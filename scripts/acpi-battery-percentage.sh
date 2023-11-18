#!/usr/bin/env bash

battery_icon="$1"

if command -v acpi &>/dev/null
then
    state="$(acpi -b | grep -o '[0-9]\+%')"
    echo "${battery_icon} ${state}"
else
    echo "ACPI Unavailable"
fi
