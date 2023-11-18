# Tmux ACPI

This `tmux` plugin creates following acpi information:

- Battery State: `[Discharing | Charging | Not Charging]`

![Battery State](battery-state.png)

- Battery Percentage: `[1% | 100%]`

![Battery Percentage](battery-percentage.png)

- Battery Capacity: `[design capacity / last full charge capacity] mAh` `[3100/4100] mAh`

![Battery Capacity](battery-capacity.png)

- Thermal Status: `[degrees C|F|Kelvin / critical temprature]` `[35/102 C | 100/215 F | 311/375 Kelvin]`

![Thermal Status](thermal-status.png)

- AC-Adapter Status: `[AC Connected | On Battery]`

![AC Adapter Status](ac-adapter-status.png)

## Usage

Add any of the desired indicators to your `status-left` or `status-right` tmux variables as follows:

*~/.tmux.conf*
```
set -g status-right '#{acpi_battery_state} %a %Y-%m-%d %H:%M'
```

Available indicators are as follows:

- Battery State: `#{acpi_battery_state}`
- Battery Percentage: `#{acpi_battery_percentage}`
- Battery Capacity: `#{acpi_battery_capacity}`
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
set -g @acpi_icon_battery_charging ' '
set -g @acpi_icon_battery_discharging ' '
set -g @acpi_icon_battery_not_charging ' '
set -g @acpi_icon_adapter_connected ' '
set -g @acpi_icon_adapter_disconnected ' '
```
