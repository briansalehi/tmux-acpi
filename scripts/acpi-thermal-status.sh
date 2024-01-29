#!/usr/bin/env bash

thermal_cold_icon="$1"
thermal_hot_icon="$2"
thermal_critical_icon="$3"
thermal_unit="$4"

if command -v acpi &>/dev/null
then
    # thermal unit can be customized by user
    case "${thermal_unit,,}" in
        c|celsius) opt=""; thermal_unit="°C" ;;
        k|kelvin) opt="-k"; thermal_unit="Kelvin" ;;
        f|fahrenheit) opt="-f"; thermal_unit="°F" ;;
    esac

    # add space to avoid overlaping of wide character icons with values
    [ "${#thermal_unit}" -gt 1 ] && thermal_unit+=" "
    [ "${#thermal_cold_icon}" -gt 1 ] && thermal_cold_icon+=" "
    [ "${#thermal_hot_icon}" -gt 1 ] && thermal_hot_icon+=" "
    [ "${#thermal_critical_icon}" -gt 1 ] && thermal_critical_icon+=" "

    # retrieves current thermal degree based on user defined unit, celsius by default
    current_degree="$(acpi -ti "${opt}" | grep 'Thermal 0' | head -n1 | grep -o '[0-9]\+\.[0-9]')"
    #passive_degree="$(acpi -ti "${opt}" | grep 'Thermal 0' | grep 'passive' | grep -o '[0-9]\+\.[0-9]')"
    critical_degree="$(acpi -ti "${opt}" | grep 'Thermal 0' | grep 'critical' | grep -o '[0-9]\+\.[0-9]')"

    # thresholds can also be customized by user
    # but I've really got no more time to spend on this
    # TODO: please contribute ♡
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
