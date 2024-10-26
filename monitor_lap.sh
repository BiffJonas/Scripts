#!/bin/bash
set -e

xrandr --auto

LAPTOP_SCREEN=$(xrandr | grep "eDP-1" | awk '{print $1}')
EXTERNAL_MONITORS=($(xrandr | grep -v "eDP-1" | grep ' connected' | awk '{print $1}'))

echo "Internal Monitor: $LAPTOP_SCREEN"
echo "External Monitors: ${EXTERNAL_MONITORS[@]}"

if [ ${#EXTERNAL_MONITORS[@]} -ge 1 ]; then
    xrandr --output "${EXTERNAL_MONITORS[0]}" --primary --right-of "$LAPTOP_SCREEN"
    xrandr --output "${EXTERNAL_MONITORS[1]}" --off
    xrandr --output "$LAPTOP_SCREEN" --off
else
    xrandr --output "$LAPTOP_SCREEN" --auto --brightness 1.2
fi



# if [ -n "$EXTERNAL_MONITORS" ]; then
#     previous_monitor="$LAPTOP_SCREEN"
#     while read -r monitor; do
#         xrandr --output "$monitor" --right-of "$previous_monitor"
#         previous_monitor="$monitor"

#     done <<< "$EXTERNAL_MONITORS"
#     xrandr --output "$LAPTOP_SCREEN" --off
# else
#     xrandr --output "$LAPTOP_SCREEN" --auto --brightness 2
# fi
