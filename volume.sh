#!/usr/bin/env bash

TRIGGER=$1
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -P -o '[0-9]+(?=%)' | cut -d$'\n' -f1)
STATE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

muteicon="/home/zuxroy/.local/share/icons/custom/volume-mute.svg"
volhicon="/home/zuxroy/.local/share/icons/custom/volume-high.svg"
vollicon="/home/zuxroy/.local/share/icons/custom/volume-low.svg"

if [ $TRIGGER -eq 0 ]; then
    if [ $VOLUME -gt 0 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -1%
    fi
elif [ $TRIGGER -eq 1 ]; then
    if [ $VOLUME -lt 100 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +1%
    fi
elif [ $TRIGGER -eq 2 ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -P -o '[0-9]+(?=%)' | cut -d$'\n' -f1)
STATE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ $STATE = "yes" ]; then
    dunstify "Muted" -i $muteicon -r 9991 -t 1000
else
    if [ $VOLUME -gt 40 ]; then
        dunstify "$VOLUME%" -i $volhicon -r 9991 -t 1000 -h int:value:$VOLUME 
    else
        dunstify "$VOLUME%" -i $vollicon -r 9991 -t 1000 -h int:value:$VOLUME
    fi
fi
