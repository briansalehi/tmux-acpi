#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
    local option_value
    option_value="$(tmux show-option -qgv "${1}")"
    echo "${option_value:-$2}"
}

set_tmux_option() {
    local side="${1}"
    local status_value

    # side should be either "left" or "right"
    status_value="$(get_tmux_option "${side}")"

    # replace placeholders with values
    status_value="${status_value/\#\{acpi_battery_state\}/$acpi_battery_state}"
    status_value="${status_value/\#\{acpi_battery_percentage\}/$acpi_battery_percentage}"
    status_value="${status_value/\#\{acpi_battery_capacity\}/$acpi_battery_capacity}"
    status_value="${status_value/\#\{acpi_battery_health\}/$acpi_battery_health}"
    status_value="${status_value/\#\{acpi_thermal_status\}/$acpi_thermal_status}"
    status_value="${status_value/\#\{acpi_adapter_status\}/$acpi_adapter_status}"

    tmux set-option -qg "$1" "${status_value}"
}

# colors
acpi_format_begin=$(get_tmux_option "@acpi_format_begin" "#[fg=default]")
acpi_format_end=$(get_tmux_option "@acpi_format_end" "#[fg=default]")

# icons
acpi_icon_battery=$(get_tmux_option "@acpi_icon_battery" "🔋")
acpi_icon_battery_charging=$(get_tmux_option "@acpi_icon_battery_charging" "🔋")
acpi_icon_battery_discharging=$(get_tmux_option "@acpi_icon_battery_discharging" "🪫")
acpi_icon_battery_not_charging=$(get_tmux_option "@acpi_icon_battery_not_charging" "🔋")
acpi_icon_battery_health=$(get_tmux_option "@acpi_icon_battery_health" "⛑ ")
acpi_icon_thermal_critical=$(get_tmux_option "@acpi_icon_thermal_critical" "☢️ ")
acpi_icon_thermal_hot=$(get_tmux_option "@acpi_icon_thermal_hot" "🔥")
acpi_icon_thermal_cold=$(get_tmux_option "@acpi_icon_thermal_cold" "❄️ ")
acpi_icon_adapter_connected=$(get_tmux_option "@acpi_icon_adapter_connected" "⚡️")
acpi_icon_adapter_disconnected=$(get_tmux_option "@acpi_icon_adapter_disconnected" "🔌")

# commands
acpi_battery_state="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-state.sh ${acpi_icon_battery_charging} ${acpi_icon_battery_discharging} ${acpi_icon_battery_not_charging})${acpi_format_end}"
acpi_battery_percentage="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-percentage.sh ${acpi_icon_battery})${acpi_format_end}"
acpi_battery_capacity="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-capacity.sh)${acpi_format_end}"
acpi_battery_health="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-battery-health.sh ${acpi_icon_battery_health})${acpi_format_end}"
acpi_thermal_status="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-thermal-status.sh ${acpi_icon_thermal_cold} ${acpi_icon_thermal_hot} ${acpi_icon_thermal_critical})${acpi_format_end}"
acpi_adapter_status="${acpi_format_begin}#($CURRENT_DIR/scripts/acpi-adapter_status.sh ${acpi_icon_adapter_connected} ${acpi_icon_adapter_disconnected})${acpi_format_end}"

set_tmux_option "status-left"
set_tmux_option "status-right"
