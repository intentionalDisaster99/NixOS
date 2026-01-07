function handle_monitor_power
    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "eDP-1" # Your internal display

    # Loop forever
    while true
        # Check power status (BAT0 or AC - check /sys/class/power_supply/ if unsure)
        set POWER_STATUS (cat /sys/class/power_supply/AC/online 2>/dev/null; or echo 1)

        if test "$POWER_STATUS" = "1"
            # AC MODE: If mpvpaper isn't running, start it
            if not pgrep -x "mpvpaper" > /dev/null
                echo "Switched to AC: Starting Video Wallpaper"
                mpvpaper -o "no-audio --loop" $MONITOR $VIDEO_WALLPAPER &
                disown
            end
        else
            # BATTERY MODE: If mpvpaper IS running, kill it to show static hyprpaper
            if pgrep -x "mpvpaper" > /dev/null
                echo "Switched to Battery: Stopping Video Wallpaper"
                killall mpvpaper
            end
        end
        
        # Check every 5 seconds
        sleep 5
    end
end