#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
MONITOR="eDP-1" 
SLEEP_TIME=300 

while true; do
  for wp in "$WALLPAPER_DIR"/*; do
    hyprctl hyprpaper wallpaper "$MONITOR","$wp"
    sleep "$SLEEP_TIME"
  done
done
