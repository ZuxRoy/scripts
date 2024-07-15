#!/usr/bin/env bash

CHARGING=$1
BATTERY=$(acpi -b | grep -P -o '[0-9]+(?=%)')

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

if [ "$CHARGING" -eq 1 ]; then
    DISPLAY=:0 /usr/bin/notify-send "Connected" "${BATTERY}% battery charging" -u normal -i "/home/zuxroy/.local/share/icons/custom/battery-charging.svg" -t 5000 -r 9991
elif [ "$CHARGING" -eq 0 ]; then
    DISPLAY=:0 /usr/bin/notify-send "Disconnected" "${BATTERY}% battery discharging" -u normal -i "/home/zuxroy/.local/share/icons/custom/battery-full.svg" -t 5000 -r 9991
else
    STATE=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:" | awk '{ print $2 }')
    if [ "$STATE" = "charging" ]; then
        DISPLAY=:0 /usr/bin/notify-send "Charging" "${BATTERY}% charge remaining" -u normal -i "/home/zuxroy/.local/share/icons/custom/battery-full.svg" -t 5000 -r 9991
    else
        DISPLAY=:0 /usr/bin/notify-send "${BATTERY}% charge remaining" -u normal -i "/home/zuxroy/.local/share/icons/custom/battery-full.svg" -t 5000 -r 9991
    fi
fi
