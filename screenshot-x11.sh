#!/bin/bash

mkdir -p "$HOME/Pictures/Screenshots"

eval $(xdotool getmouselocation --shell)
start_x=$X
start_y=$Y

filename="$HOME/Pictures/Screenshots/screenshot-$(date +"%d-%m-%Y_%H-%M-%S").png"

maim --select --hidecursor > "$filename"
exit_status=$?

if [[ "$exit_status" -ne 0 ]]; then
    rm -rf "$filename"
    notify-send "Screenshot cancelled" -r 9991 -t 5000 -u low 
    exit
fi

notify-send "Screenshot saved" -r 9991 -t 5000 -i "$filename"
feh -F "$filename"

choice=$(echo -e "(Y) Yes\n(N) No\n(R) Retake screenshot" | rofi -dmenu -i -p "Copy screenshot ? " -l 3)

if [[ "$choice" = "(Y) Yes" ]]; then
    notify-send "Screenshot copied" -r 9991 -t 5000 -i "$HOME/.local/share/icons/custom/clipboard.svg"
    cat "$filename" | xclip -selection clipboard -t image/png
elif [[ "$choice" = "(R) Retake screenshot" ]]; then 
    notify-send "Screenshot deleted" -r 9991 -t 5000 -i "$HOME/.local/share/icons/custom/delete.svg"
    rm -rf "$filename"
    screenshot-x11.sh
fi
