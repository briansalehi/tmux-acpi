#!/usr/bin/env bash
# Utilizes tmux status bar with acpi output

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
    local option_value
    option_value="$(tmux show-option -qgv "${1}")"
    [ "${option_value}" == '-' ] || echo "${option_value:-$2}"
}

set_tmux_option() {
    local side="${1}"
    local status_value

    # side should be either "left" or "right"
    status_value="$(get_tmux_option "${side}")"

    # replace placeholders with values and combine all parts of status bar
    status_value="${status_value/\#\{acpi_battery_percentage\}/$acpi_battery_percentage}"
    status_value="${status_value/\#\{acpi_battery_timer\}/$acpi_battery_timer}"
    status_value="${status_value/\#\{acpi_battery_capacity\}/$acpi_battery_capacity}"
    status_value="${status_value/\#\{acpi_battery_health\}/$acpi_battery_health}"
    status_value="${status_value/\#\{acpi_battery_status\}/$acpi_battery_status}"
    status_value="${status_value/\#\{acpi_thermal_status\}/$acpi_thermal_status}"
    status_value="${status_value/\#\{acpi_adapter_status\}/$acpi_adapter_status}"

    tmux set-option -qg "$1" "${status_value}"
}

# values
acpi_thermal_unit="$(get_tmux_option "@acpi_icon_thermal_unit" "Celsius")"

# colors
acpi_format_begin="$(get_tmux_option "@acpi_format_begin")"
acpi_format_end="$(get_tmux_option "@acpi_format_end")"

# icons
acpi_icon_battery_full="$(get_tmux_option "@acpi_icon_battery_full" "🔋")"
acpi_icon_battery_low="$(get_tmux_option "@acpi_icon_battery_low" "🪫")"
acpi_icon_battery_health="$(get_tmux_option "@acpi_icon_battery_health" "🩺")"
acpi_icon_thermal_critical="$(get_tmux_option "@acpi_icon_thermal_critical" "☢️ ")"
acpi_icon_thermal_hot="$(get_tmux_option "@acpi_icon_thermal_hot" "🔥")"
acpi_icon_thermal_cold="$(get_tmux_option "@acpi_icon_thermal_cold" "❄️ ")"
acpi_icon_adapter_connected="$(get_tmux_option "@acpi_icon_adapter_connected" "⚡️")"
acpi_icon_adapter_disconnected="$(get_tmux_option "@acpi_icon_adapter_disconnected" "🔌")"
acpi_icon_battery_discharging="$(get_tmux_option "@acpi_icon_battery_discharging" "⚰️ ")"
acpi_icon_battery_charging="$(get_tmux_option "@acpi_icon_battery_charging" "🚀")"
acpi_icon_battery_full_charge="$(get_tmux_option "@acpi_icon_battery_full_charge" "💤")"

# commands
#   NOTE: icons given to function arguments for dynamic visualization
acpi_battery_status="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-status.sh)${acpi_format_end}"
acpi_battery_percentage="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-percentage.sh ${acpi_icon_battery_low} ${acpi_icon_battery_full})${acpi_format_end}"
acpi_battery_timer="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-timer.sh ${acpi_icon_battery_discharging} ${acpi_icon_battery_charging} ${acpi_icon_battery_full_charge})${acpi_format_end}"
acpi_battery_capacity="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-capacity.sh)${acpi_format_end}"
acpi_battery_health="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-health.sh ${acpi_icon_battery_health})${acpi_format_end}"
acpi_thermal_status="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-thermal-status.sh ${acpi_icon_thermal_cold} ${acpi_icon_thermal_hot} ${acpi_icon_thermal_critical} ${acpi_thermal_unit})${acpi_format_end}"
acpi_adapter_status="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-adapter_status.sh ${acpi_icon_adapter_connected} ${acpi_icon_adapter_disconnected})${acpi_format_end}"

# update status bar
set_tmux_option "status-left"
set_tmux_option "status-right"
