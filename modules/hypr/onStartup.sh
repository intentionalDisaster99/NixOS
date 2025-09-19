#!/usr/bin/env bash

# Start Hyprpaper with the custom config
hyprpaper -c /etc/nixos/modules/hypr/hyprpaper.conf &

# Start the wallpaper cycle script
/etc/nixos/modules/hypr/wallpaperCycle.sh &

# Start Waybar with your custom config and style
waybar -c /etc/nixos/modules/hypr/waybar/config -s /etc/nixos/modules/hypr/waybar/style.css &
