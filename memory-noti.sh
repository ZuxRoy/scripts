#!/usr/bin/env bash

mem=$(free -m | awk '/^Mem:/ {printf "Total Memory \t: %.2f GB\nUsed Memory \t: %.2f GB\nFree memory \t: %.2f GB\n", $2/1024, $3/1024, $4/1024}')
dunstify "$mem" -u normal -t 5000 -r 9991 -i "$HOME/.local/share/icons/custom/memory.svg"
