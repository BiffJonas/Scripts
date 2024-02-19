#!/bin/bash

languages=$(echo "java javascript docker bash" | tr " " "\n")
core_utils=$(echo "grep find awk sed" | tr " " "\n")

selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "Gimme Your Query: " query

if echo $languages | grep -qs $selected; then
    tmux split-window -h bash -c "curl cht.sh/$selected/$(echo $query | tr " " "+") | less -R"
else
    tmux split-window -h bash -c "curl cht.sh/$selected~$(echo $query | tr " " "+") | less -R"
fi
