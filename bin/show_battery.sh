#!/bin/bash

battery_status=$(/usr/bin/upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ { print $2 }' | tr -d %)

icon_package=/usr/share/icons/Oranchelo/status/
icon_empty=$icon_package/battery-empty.svg
icon_critical=$icon_package/battery-caution.svg
icon_low=$icon_package/battery-low.svg
icon_medium=$icon_package/battery-good.svg
icon_full=$icon_package/battery-full.svg

if [ $battery_status -le 10 ]
then
    icon="$icon_empty"
elif [ $battery_status -le 25 ]
then
    icon="$icon_critical"
elif [ $battery_status -le 50 ]
then
    icon="$icon_low"
elif [ $battery_status -le 75 ]
then
    icon="$icon_medium"
else
    icon="$icon_full"
fi

/usr/bin/notify-send "Battery at $battery_status%" -t 5000 -i "$icon"
