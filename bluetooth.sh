#!/usr/bin/env bash
dmenu_font="pango:JetBrainsMono Nerd Font 8"

SELECTED=$(bluetoothctl devices | sed -n 's/^Device \([0-9A-F:]*\) \(.*\)$/\2/p' | dmenu -l 10 -p "Select Bluetooth Device:" -fn "$dmenu_font")
SELECTED_MAC=$(bluetoothctl devices | grep "$SELECTED" | awk '{print $2}')

bluetoothctl connect $SELECTED_MAC
