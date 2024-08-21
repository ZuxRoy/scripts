#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    dirs=$(find ~/git ~/code ~/dev ~/dotfiles ~/scripts -mindepth 1 -maxdepth 1 -type d -not -name '.git')
    if [ -d ~/scripts ]; then
        list=$(printf "%s\n%s" "$dirs" "/home/zuxroy/scripts")
    fi
    selected=$(echo "$list" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
else
    tmux switch-client -t $selected_name
fi