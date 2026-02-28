function power_save_toggle
    
    set MODE_FILE "/tmp/battery_saver_mode"

    # Defaulting to inactive
    if not test -f $MODE_FILE
        echo "normal" > $MODE_FILE
    end

    set CURRENT (cat $MODE_FILE)

    if test "$CURRENT" = "battery_saver"

        # Saving the current mode
        echo "normal" > $MODE_FILE

        # Turning off the wallpaper
        echo "off" > "/tmp/wallpaper_mode"

        notify-send -u low -t 2000 "Battery saver turned off."
    else if test "$CURRENT" = "normal"

        # Saving the mode 
        echo "battery_saver" > $MODE_FILE

        # Turning on the wallpaper to normal mode
        echo "normal" > "/tmp/wallpaper_mode"

        notify-send -u low -t 2000 "Battery saver turned on."
    end

    # Changing the waybar to use the alt format 
    pkill -SIGRTMIN+8 waybar
    
end