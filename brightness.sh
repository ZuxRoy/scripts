#!/usr/bin/env bash

TRIGGER=$1
MAX=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
ACTUAL=$(cat /sys/class/backlight/amdgpu_bl0/actual_brightness)

brightnessicon="$HOME/.local/share/icons/custom/brightness.svg"

if [ $TRIGGER -eq 0 ]; then
    if [ $ACTUAL -gt 0 ]; then
        VAL=$(brightnessctl set 1- | grep Current | awk -F '[()%]' '{print $2}')
    else
        VAL=0
    fi
elif [ $TRIGGER -eq 1 ]; then
    if [ $ACTUAL -lt $MAX ]; then
        VAL=$(brightnessctl set 1+ | grep Current | awk -F '[()%]' '{print $2}')
    else
        VAL=100
    fi
fi

dunstify "$VAL%" -i $brightnessicon -r 9991 -t 1000 -h int:value:$VAL
