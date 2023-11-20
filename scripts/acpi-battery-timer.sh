#!/usr/bin/env bash

discharging_icon="$1"
charging_icon="$2"
full_charge_icon="$3"

if command -v acpi &>/dev/null
then
    output="$(acpi -b | grep 'Battery 0' | grep -oE '[0-9]{2}:[0-9]{2}:[0-9]{2} \w\+')"
    timer="${output% *}"
    state="${output#* }"

    [ "${#discharging_icon}" -gt 1 ] && discharging_icon+=" "
    [ "${#charging_icon}" -gt 1 ] && charging_icon+=" "
    [ "${#full_charge_icon}" -gt 1 ] && full_charge_icon+=" "

    case "${state,,}" in
        "remaining") echo "${discharging_icon}${timer}" ;;
        "until charged") echo "${charging_icon}${timer}" ;;
        "full charged") echo "${full_charge_icon}${timer}" ;;
    esac
fi
