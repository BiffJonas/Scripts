#!/bin/bash

session="RPG"

tmux new-session -s "RPG" -d -c "$HOME/repos/rpg_game"
tmux rename-window -t 1 "Neovim"
tmux send-keys -t $session:1 "nvim -S Session.vim" C-m

tmux new-window -t $session:2 -n "Run Build" -c "$HOME/repos/rpg_game"
  
# Attach Session, on the Main window
tmux attach-session -t $session:1
