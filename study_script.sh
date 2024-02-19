#!/bin/bash


session="NetworkSecurity"

tmux new-session -d -s $session -c "$HOME/obsidian/Obsidian_Vault/Network Security"
tmux rename-window -t 1 "Notes"
tmux send-keys -t $session:1 "nvim ." C-m

tmux new-window -t $session:2 -n "Shenanighans" -c "$HOME/obsidian/Obsidian_Vault/Network Security"

# Attach Session, on the Main window
tmux attach-session -t $session:1
