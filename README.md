# Tmux ACPI

This `tmux` plugin creates following acpi information:

- Battery Status: `[Discharing | Charging | Not Charging]`

![Battery Status](images/battery-status.png)

- Battery Percentage: `[1% | 100%]`

![Battery Percentage](images/battery-percentage.png)

- Battery Capacity: `[design capacity / last full charge capacity] mAh` `[3100/4100] mAh`

![Battery Capacity](images/battery-capacity.png)

- Battery Health: `[89%]`

![Battery Health](images/battery-health.png)

- Thermal Status: `[degrees C|F|Kelvin / critical temprature]` `[35/102 C | 100/215 F | 311/375 Kelvin]`

![Thermal Status](images/thermal-status.png)

- AC-Adapter Status: `[AC Connected | On Battery]`

![AC Adapter Status](images/ac-adapter-status.png)

## Usage

Add any of the desired indicators to your `status-left` or `status-right` tmux variables as follows:

*~/.tmux.conf*
```
set -g status-right '#{acpi_adapter_status} #{acpi_battery_percentage} #{acpi_battery_capacity} #{acpi_battery_health} #{acpi_thermal_status} %a %Y-%m-%d %H:%M'
```

Available indicators are as follows:

- Battery Status: `#{acpi_battery_status}`
- Battery Percentage: `#{acpi_battery_percentage}`
- Battery Capacity: `#{acpi_battery_capacity}`
- Battery Health: `#{acpi_battery_health}`
- Thermal Status: `#{acpi_thermal_status}`
- AC-Adapter Status: `#{acpi_adapter_status}`

## Installation

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
2. Add this plugin to your `~/.tmux.conf`: `set @plugin 'briansalehi/tmux-acpi`
3. Press `[prefix] + I` to install.

## Configuration

Following configuration variables can be set in `~/.tmux.conf`.
Variables are shown with their corresponding default values.

```
# Colors
set -g @acpi_format_begin '#[fg=white,bg=colour236]'
set -g @acpi_format_end '#[fg=white,bg=black]'

# Icons
set -g @acpi_icon_battery '🔋'
set -g @acpi_icon_battery_charging '🔋'
set -g @acpi_icon_battery_discharging '🪫'
set -g @acpi_icon_battery_not_charging '🔋'
set -g @acpi_icon_battery_health '⛑ '
set -g @acpi_icon_adapter_connected '⚡️'
set -g @acpi_icon_adapter_disconnected '🔌'
set -g @acpi_icon_thermal_cold '❄️ '
set -g @acpi_icon_thermal_hot '🔥'
set -g @acpi_icon_thermal_critical '☢️ '
```
