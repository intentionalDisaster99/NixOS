function power_save_toggle
    
    set MODE_FILE "/tmp/battery_saver_mode"
    set CONFIG_DIR "dotfiles/waybar"

    # Defaulting to inactive
    if not test -f $MODE_FILE
        echo "normal" > $MODE_FILE
    end

    set CURRENT (cat $MODE_FILE)

    if test "$CURRENT" = "battery_saver"

        # Saving the current mode
        echo "normal" > $MODE_FILE

        # Switching to the normal waybar
        ln -sf config-normal "$CONFIG_DIR/config"

        # Turning the wallpaper to normal
        echo "normal" > "/tmp/wallpaper_mode"

        notify-send -u low -t 2000 "Battery saver turned off."
    else if test "$CURRENT" = "normal"

        # Saving the mode 
        echo "battery_saver" > $MODE_FILE

        # Switching to the low power config
        ln -sf config-low-power "$CONFIG_DIR/config"

        # Turning off the wallpaper
        echo "off" > "/tmp/wallpaper_mode"

        notify-send -u low -t 2000 "Battery saver turned on."
    end

    # Send reload signal to Waybar
    killall -SIGUSR2 waybar

end