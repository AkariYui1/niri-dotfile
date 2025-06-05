#!/bin/bash

color=`niri msg pick-color | grep Hex | cut -d# -f2`
rgb_color=`zenity --color-selection --title="Copy color to Clipboard" --color=#$color`

if [ "$rgb_color" != "" ]; then
    hex_color="#"
    for value in $(echo "${rgb_color}" | grep -E -o -m1 '[0-9]+'); do
        hex_color="$hex_color$(printf "%.2x" $value)"
    done
    echo $hex_color | wl-copy -n
fi
