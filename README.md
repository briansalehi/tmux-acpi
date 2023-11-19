# Tmux ACPI

This `tmux` plugin represents `acpi` information available on your status bar.

### Battery Status & Percentage

![Battery Status](images/acpi-battery-discharing.png)
![Battery Status](images/acpi-battery-charging.png)

Battery status indicator can be either of `Discharing`, `Charging`, and `Not
Charging` values.

Battery percentage indicator shows the charged capacity of your battery in
percentage from 0 to 100. Of course you will never witness the 0 percent of
your battery, not even with time travel.

### Battery Capacity & Health

![Battery Capacity](images/acpi-battery-health.png)

Battery capacity indicator shows the last full charged capacity value of your
battery. Note that this has nothing to do with how much time the adapter was
connected to your laptop, this is the capacity that is functional! Yes we are
all screwed and we don't know it until we see how much capacity is gone.
There's not much on seeing dead cells of your battery unless you want to suffer
witnessing your battery going down on a daily basis.

### Thermal Status

![Thermal Status](images/acpi-thermal-cold.png)

This indicator shows the tempraturue of your device. It could be cold, hot or
reach its critical temprature where you should ask yourself what the heck are
you doing to your device.

### AC-Adapter Status

![AC Adapter Status](images/acpi-adapter-online.png)
![AC Adapter Status](images/acpi-adapter-offline.png)

## Usage

Add any of the desired indicators to your `status-left` or `status-right` tmux
variables as follows:

*~/.tmux.conf*
```
set -g status-right '| #{acpi_adapter_status} | #{acpi_battery_percentage} #{acpi_battery_status} | #{acpi_battery_health} #{acpi_battery_capacity} | #{acpi_thermal_status}|'
```

Available indicators are as follows:

- Battery Percentage: `#{acpi_battery_percentage}`
- Battery Capacity: `#{acpi_battery_capacity}`
- Battery Health: `#{acpi_battery_health}`
- Battery Status: `#{acpi_battery_status}`
- Thermal Status: `#{acpi_thermal_status}`
- AC-Adapter Status: `#{acpi_adapter_status}`

## Installation

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
2. Add this plugin to your `~/.tmux.conf`: `set @plugin 'briansalehi/tmux-acpi'`
3. Press `[prefix] + I` to install.

## Configuration

Following configuration variables can be set in `~/.tmux.conf`.
Variables are shown with their corresponding default values.

*~/.tmux.conf*
```
# Colors
set -g @acpi_format_begin '#[fg=white,bg=colour236]'
set -g @acpi_format_end '#[fg=white,bg=black]'

# Icons
set -g @acpi_icon_battery_full '🔋'
set -g @acpi_icon_battery_low '🪫'
set -g @acpi_icon_battery_health '🩺'
set -g @acpi_icon_adapter_connected '⚡️'
set -g @acpi_icon_adapter_disconnected '🔌'
set -g @acpi_icon_thermal_cold '❄️ '
set -g @acpi_icon_thermal_hot '🔥'
set -g @acpi_icon_thermal_critical '☢️ '

# Values
set -g @acpi_icon_thermal_unit 'Celsius' # Fahrenheit, Kelvin
```
