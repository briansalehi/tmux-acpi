#!/usr/bin/env bash

thermal_cold_icon="$1"
thermal_hot_icon="$2"
thermal_critical_icon="$3"
thermal_unit="$4"

if command -v acpi &>/dev/null
then
    case "${thermal_unit,,}" in
        c|celsius) opt=""; thermal_unit="°C" ;;
        k|kelvin) opt="-k"; thermal_unit="Kelvin" ;;
        f|fahrenheit) opt="-f"; thermal_unit="°F" ;;
    esac

    [ "$(wc -c <<< "${thermal_unit}")" -gt 4 ] && thermal_unit+=" "
    [ "$(wc -c <<< "${thermal_cold_icon}")" -gt 4 ] && thermal_cold_icon+=" "
    [ "$(wc -c <<< "${thermal_hot_icon}")" -gt 4 ] && thermal_hot_icon+=" "
    [ "$(wc -c <<< "${thermal_critical_icon}")" -gt 4 ] && thermal_critical_icon+=" "

    degrees="$(acpi -ti "${opt}" | grep 'Thermal 0' | grep -o '[0-9]\+\.[0-9]' | xargs)"
    current_degree="${degrees% *}"
    critical_degree="${degrees#* }"

    if [ "${current_degree#*.}" -lt 75 ]
    then
        echo "${thermal_cold_icon}${current_degree}/${critical_degree}${thermal_unit}"
    elif [ "${current_degree#*.}" -ge 75 ]
    then
        echo "${thermal_hot_icon}${current_degree}/${critical_degree}${thermal_unit}"
    elif [ "${current_degree#*.}" -ge 95 ]
    then
        echo "${thermal_critical_icon}${current_degree}/${critical_degree}${thermal_unit}"
    else
        echo "Thermal Error"
    fi
else
    echo
fi
