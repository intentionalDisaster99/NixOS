function handle_monitor_power
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4"
    set MONITOR "eDP-1"

    while true
        # 1. Check for Manual Eco Mode override
        if test -f /tmp/eco_mode
            if pgrep -x "mpvpaper" > /dev/null
                echo "Eco Mode Enabled: Stopping Video"
                killall mpvpaper
            end
            sleep 3
            continue # Skip the rest of the loop
        end

        # 2. Standard Power Check
        set POWER_STATUS (cat /sys/class/power_supply/AC/online 2>/dev/null; or echo 1)

        if test "$POWER_STATUS" = "1"
            # AC MODE
            if not pgrep -x "mpvpaper" > /dev/null
                mpvpaper -o "no-audio --loop" $MONITOR $VIDEO_WALLPAPER &
                disown
            end
        else
            # BATTERY MODE
            if pgrep -x "mpvpaper" > /dev/null
                killall mpvpaper
            end
        end
        
        sleep 5
    end
end