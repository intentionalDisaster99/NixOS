#!/usr/bin/env fish

set THEME_FILE "$HOME/.cache/wallrizz/current_theme.css"

# If the theme file exists, copy it to a place Waybar can read
if test -f $THEME_FILE
    cp $THEME_FILE "$HOME/.config/waybar/colors.css"
end

systemctl --user restart waybar