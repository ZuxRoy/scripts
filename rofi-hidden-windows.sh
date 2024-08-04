#!/usr/bin/env bash

applications=()
nodeids=()
for node in $(bspc query -N -n .hidden); do
    classname=$(bspc query --node "$node" -T | jq -r '.client.className // ""')
    if [[ -n "$classname" ]]; then
        nodeids+=("$node")
        applications+=("$classname [$node]")
    fi
done

if [[ ${#applications[@]} -gt 0 ]]; then
    selected=$(rofi -dmenu -i <<< "$(printf "%s\n" "${applications[@]}")")
else
    notify-send "No hidden windows" -t 3000
    exit 0
fi

if [[ -n "$selected" ]]; then
    selectedid=$(echo "$selected" | awk -F '[\\[\\]]' '{print $2}')
    bspc node $selectedid -g hidden=off
fi
