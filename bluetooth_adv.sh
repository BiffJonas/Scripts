#!/usr/bin/env bash

set -euo pipefail

dmenu_font="pango:JetBrainsMono Nerd Font 8"

OPTION=$(echo -e "connect\ndisconnect" | dmenu -l 2 -fn dmenu_font)

get_formatted_device_info() {
    # Retrieve device information from bluetoothctl
    bluetoothctl devices | cut -f2 -d' ' | while read uuid; do
    bluetoothctl info "$uuid"
done | awk '
/Device/ { mac = $2 } 
/Name/ { 
# Capture the entire device name (multiple words)
name = $2; for (i = 3; i <= NF; i++) name = name " " $i 
} 
/Connected/ { status = $2; if (status == "yes") printf "Device: %s name: %s: connected: %s\n", mac, name, status }
'
}

# Main menu options
if [[ $OPTION == "disconnect" ]]; then
    FORMATTED_DEVICE_INFO=$(get_formatted_device_info)
    if [[ -z $FORMATTED_DEVICE_INFO ]]; then
        dunstify "No connected devices found" --urgency=low
        exit 1;
    fi
    NAMES=$(echo "$FORMATTED_DEVICE_INFO" | awk -F': ' '{ print $3}')
    SELECTED_DEVICE=$( echo "$NAMES" | dmenu -l 10 -p "Disconnect Bluetooth Device:" -fn dmenu_font)
    MAC_ADDRESS=$( echo "$FORMATTED_DEVICE_INFO" | grep "$SELECTED_DEVICE" | cut -f2 -d' ')
    bluetoothctl disconnect "$MAC_ADDRESS"
    dunstify "Successfully disconnected from \"$SELECTED_DEVICE\"" --urgency=low
    exit 0
fi

if [[ $OPTION == "connect" ]]; then
    SELECTED_NAME=$(bluetoothctl devices | sed -n 's/^Device \([0-9A-F:]*\) \(.*\)$/\2/p' | dmenu -l 10 -p "Connect Bluetooth Device:" -fn dmenu_font)
    SELECTED_MAC=$(bluetoothctl devices | grep "$SELECTED_NAME" | awk '{print $2}')
    dunstify "Attempting to connect to \"$SELECTED_NAME\"" --urgency=low
    if bluetoothctl connect $SELECTED_MAC; then
        dunstify "Successfully connected to \"$SELECTED_NAME\"" --urgency=low
    else
        dunstify "Failed connecting to $SELECTED_NAME" --urgency=low
        exit 1
    fi
fi
