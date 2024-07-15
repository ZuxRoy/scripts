#!/usr/bin/env bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
battery=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | awk '{ print $2 }' | tr -d '%')
state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:" | awk '{ print $2 }')
lower_limit=20
upper_limit=96
critical_limit=5

if [ "$battery" -lt "$lower_limit" ]; then
    if [ "$state" != "charging" ]; then
        DISPLAY=:0 /usr/bin/notify-send --urgency=normal "Battery Low" "Plug in! $battery% charge remaining" -i "/home/zuxroy/.local/share/icons/custom/battery_low.svg" -r 9991
    fi
elif [ "$battery" -gt "$upper_limit" ]; then
    if [ "$state" == "charging" ]; then
        DISPLAY=:0 /usr/bin/notify-send --urgency=normal "Battery Almost Full" "Charged up $battery%" -i "/home/zuxroy/.local/share/icons/custom/battery_full.svg" -r 9991
    fi
elif [ "$battery" -lt "$critical_limit" ]; then
    if [ "$state" != "charging" ]; then
        DISPLAY=:0 /usr/bin/notify-send --urgency=critical "Battery Almost Dead" "Charge immediately! $battery% charge remaining" -i "/home/zuxroy/.local/share/icons/custom/battery_alert.svg" -r 9991
    fi
fi
