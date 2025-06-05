#!/bin/bash

# Function to check if Waybar is running
waybar_is_running() {
    pgrep -x waybar > /dev/null
}

# Check if Waybar is running
if waybar_is_running; then
    # Waybar is running, so kill and restart it
    # notify-send -t 500 "Waybar is running. Restarting..."
    killall waybar
    killall swaync
    waybar &
    swaync &
    sleep 0.5
    notify-send -t 1000 "Waybar reloaded" "Have a nice day"
else
    # Waybar is not running, start it
    # notify-send -t 500 "Waybar is not running. Starting..."
    waybar &
    swaync &
    sleep 0.5
    notify-send -t 1000 "Waybar started" "Have a nice day"
fi
