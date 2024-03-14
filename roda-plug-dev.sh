#!/bin/bash

session="Roda-Plugin-Development"


tmux new-session -d -s $session -c "$HOME/repos/roda"
tmux rename-window -t 1 "Neovim"
tmux send-keys -t $session:1 "nvim -S Session.vim" C-m

tmux new-window -t $session:2 -n "Shenanighans" -c "$HOME/repos/roda"
tmux new-window -t $session:3 -n "Run" -c "$HOME/repos/roda/roda/deploys"
tmux split-window -h -t $session:3 -c "$HOME/repos/roda/roda/"



# Attach Session, on the Main window
tmux attach-session -t $session:1
