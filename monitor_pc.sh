#!/bin/bash
set -e

# Automatically detect monitors and configurations
xrandr --auto

# Detect laptop screen (internal monitor) and external monitors
LAPTOP_SCREEN=$(xrandr | grep "eDP-1" | awk '{print $1}')
EXTERNAL_MONITORS=($(xrandr | grep ' connected' | grep -v "eDP-1" | awk '{print $1}'))

echo "Internal Monitor: $LAPTOP_SCREEN"
echo "External Monitors: ${EXTERNAL_MONITORS[@]}"

# If there are external monitors connected
if [ ${#EXTERNAL_MONITORS[@]} -ge 1 ]; then
    if [ -n "$LAPTOP_SCREEN" ]; then  # Check that LAPTOP_SCREEN is not empty
        # Set the first external monitor as the primary and to the left of the laptop screen
        xrandr --output "${EXTERNAL_MONITORS[0]}" --primary --left-of "$LAPTOP_SCREEN"
        
        # Turn off the laptop screen
        xrandr --output "$LAPTOP_SCREEN" --off
    else
        # If LAPTOP_SCREEN was not detected, use the first external monitor as primary
        xrandr --output "${EXTERNAL_MONITORS[1]}" --primary --left-of "${EXTERNAL_MONITORS[0]}"

        # Turn off any additional external monitors to avoid conflict
        # xrandr --output "${EXTERNAL_MONITORS[1]:-}" --off  # Turn off the second monitor if it exists
    fi
else
    # If no external monitors are connected, enable laptop screen with increased brightness
    xrandr --output "$LAPTOP_SCREEN" --auto --brightness 1.2
fi
