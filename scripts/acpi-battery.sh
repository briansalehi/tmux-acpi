#!/usr/bin/env bash

# icons are selected based on battery percentage
low_battery_icon="$1" # acpi_icon_battery_low
full_battery_icon="$2" # acpi_icon_battery_full
discharging_icon="$3" # acpi_icon_battery_discharging
charging_icon="$4" # acpi_icon_battery_charging
health_icon="$5" # acpi_icon_battery_health
timer_icon="$6" # acpi_icon_timer
capacity_icon="$7" # acpi_icon_capacity
show_timer="$8" # acpi_battery_timer
show_capacity="$9" # acpi_battery_capacity
show_health="${10}" # acpi_battery_health
show_status="${11}" # acpi_battery_status

[ "${low_battery_icon}" == "-" ] && low_battery_icon=""
[ "${full_battery_icon}" == "-" ] && full_battery_icon=""
[ "${discharging_icon}" == "-" ] && discharging_icon=""
[ "${charging_icon}" == "-" ] && charging_icon=""
[ "${health_icon}" == "-" ] && health_icon=""
[ "${timer_icon}" == "-" ] && timer_icon=""
[ "${capacity_icon}" == "-" ] && capacity_icon=""

if ! command -v acpi &>/dev/null
then
    echo "ACPI Unavailable"
    exit 0
fi

# add space to avoid overlaping of wide character icons with values
#[ "${#low_battery_icon}" -gt 1 ] && low_battery_icon+=" "
#[ "${#full_battery_icon}" -gt 1 ] && full_battery_icon+=" "
#[ "${#discharging_icon}" -gt 1 ] && discharging_icon+=" "
#[ "${#charging_icon}" -gt 1 ] && charging_icon+=" "
#[ "${#health_icon}" -gt 1 ] && health_icon+=" "

battery_status() {
    local battery_index="${1:-0}"
    local state

    if [ "${show_status}" != "+" ]
    then
        return
    fi

    state="$(acpi -b | grep "Battery ${battery_index}")"
    state="${state#*: }"
    state="${state%%,*}"

    case "${state,,}" in
        "charging") echo " ${charging_icon}${charging_icon:+ }${state}" ;;
        "discharging") echo " ${discharging_icon}${charging_icon:+ }${state}" ;;
        *) ;;
    esac
}

battery_capacity() {
    local battery_index="${1:-0}"
    local capacity_pair=""

    if [ "${show_capacity}" != "+" ]
    then
        return
    fi

    capacity_pair="$(acpi -bi | grep "Battery ${battery_index}" | grep -Eo '[0-9]+ mAh' | xargs)"
    [ -n "${capacity_pair}" ] && echo -n " ${capacity_icon}" && awk '{printf "%d/%d %s\n",$3,$1,$4,$6}' <<< "${capacity_pair}"
}

battery_health() {
    local battery_index="${1:-0}"
    local health_output=""

    if [ "${show_health}" != "+" ]
    then
        return
    fi

    health_output="$(acpi -bi | grep "Battery ${battery_index}" | grep -Eo '= [0-9]+')"
    echo "${health_output:+ }${health_icon}${health_output/= /}%"
}

battery_timer() {
    local battery_index="${1:-0}"
    local output=""
    local timer=""

    if [ "${show_timer}" != "+" ]
    then
        return
    fi

    output="$(acpi -b | grep "Battery ${battery_index}" | grep -oE '[0-9]{2}:[0-9]{2}:[0-9]{2} \w+\s?\w+?')"
    timer="${output%% *}"
    echo "${timer:+ }${timer:+${timer_icon}}${timer}"
}

batteries=()

for percentage in $(acpi -b | grep -Eo '[0-9]+%')
do
    # empty batteries or acpi failures are excluded
    if [ "${percentage%\%}" -gt 0 ] && [ "${percentage%\%}" -le 40 ]
    then
        batteries+=( "${low_battery_icon}${percentage}" )
    elif [ "${percentage%\%}" -gt 40 ] && [ "${percentage%\%}" -le 100 ]
    then
        batteries+=( "${full_battery_icon}${percentage}" )
    fi
done

output=""

for index in $(seq 0 $(( ${#batteries[*]} - 1 )))
do
    battery_number=""

    if [ ${#batteries[*]} -gt 1 ]
    then
        battery_number="$((index + 1))"
    fi

    output="${output}${output:+ }${battery_number}${battery_number:+:}${batteries[$index]}$(battery_status $index)$(battery_timer $index)$(battery_health $index)$(battery_capacity $index)"
done

echo "${output}"
