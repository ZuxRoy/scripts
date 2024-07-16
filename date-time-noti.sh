#!/usr/bin/env bash

val=$(date | awk '{printf "Date : %s %s %s\nTime : %s %s\n", $1, $2, $3, $5, $6}')
dunstify "$val" -u normal -t 5000 -r 9991  -i "$HOME/.local/share/icons/custom/calendar-clock.svg"
