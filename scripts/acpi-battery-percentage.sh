#!/usr/bin/env bash

# icons are selected based on battery percentage
full_battery_icon="$1"
low_battery_icon="$2"
discharging_icon="$3"
charging_icon="$4"

if ! command -v acpi &>/dev/null
then
    echo "ACPI Unavailable"
    exit 0
fi

batteries=()

for percentage in $(acpi -b | grep -Eo '[0-9]+%')
do
    # add space to avoid overlaping of wide character icons with values
    [ "${#full_battery_icon}" -gt 1 ] && full_battery_icon+=" "
    [ "${#low_battery_icon}" -gt 1 ] && low_battery_icon+=" "

    # empty batteries or acpi failures are excluded
    if [ "${percentage%\%}" -gt 0 ] && [ "${percentage%\%}" -le 40 ]
    then
        batteries+=( "${low_battery_icon}${percentage}" )
    elif [ "${percentage%\%}" -gt 40 ] && [ "${percentage%\%}" -le 100 ]
    then
        batteries+=( "${full_battery_icon}${percentage}" )
    fi
done

battery_status() {
    local battery_index="${1:-0}"
    local state

    state="$(acpi -b | grep "Battery ${battery_index}")"
    state="${state#*: }"
    state="${state%%,*}"

    case "${state,,}" in
        "charging") echo "${charging_icon}" ;;
        "discharging") echo "${discharging_icon}" ;;
        *) ;;
    esac
}

if [ ${#batteries[*]} -gt 1 ]
then
    index=0
    output=""

    for battery in "${batteries[@]}"
    do
        output="${output}${output:+ }$((index + 1)):${batteries[$index]}$(battery_status $index)"
        index=$((index + 1))
    done

    echo "${output}"
else
    echo "${batteries[0]}$(battery_status $index)"
fi
