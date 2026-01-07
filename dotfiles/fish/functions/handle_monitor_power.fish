function handle_monitor_power
    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "eDP-1" 

    # 1. CLEANUP ON START
    # Kill any lingering instances so we start fresh
    killall mpvpaper 2>/dev/null
    sleep 1

    while true
        # 2. CHECK FOR MANUAL OVERRIDE (Eco Mode)
        if test -f /tmp/eco_mode
            if pgrep -f "mpvpaper" > /dev/null
                killall mpvpaper
            end
            sleep 5
            continue
        end

        # 3. CHECK POWER STATUS
        # Returns 1 for AC, 0 for Battery. Defaults to 1 if check fails.
        set POWER_STATUS (cat /sys/class/power_supply/AC*/online 2>/dev/null; or echo 1)

        if test "$POWER_STATUS" = "1"
            # AC MODE: Start video ONLY if it is not already running
            # We use 'pgrep -f' to match the full command line, which is safer here
            if not pgrep -f "mpvpaper" > /dev/null
                echo "Starting Video Wallpaper..."
                # Run with nohup/disown to detach completely
                nohup mpvpaper -o "no-audio --loop" $MONITOR $VIDEO_WALLPAPER >/dev/null 2>&1 &
                disown
            end
        else
            # BATTERY MODE: Kill video if running
            if pgrep -f "mpvpaper" > /dev/null
                echo "Stopping Video Wallpaper..."
                killall mpvpaper
            end
        end
        
        # Check every 5 seconds
        sleep 5
    end
end