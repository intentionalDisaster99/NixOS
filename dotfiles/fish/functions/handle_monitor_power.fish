function handle_monitor_power
    # Configuration
    # Use the path you confirmed works:
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "eDP-1" 

    # 1. CLEANUP ON START
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
        # We use ADP1 based on your 'ls' output
        set POWER_STATUS (cat /sys/class/power_supply/ADP1/online 2>/dev/null; or echo 1)

        if test "$POWER_STATUS" = "1"
            # AC MODE (Plugged In)
            if not pgrep -f "mpvpaper" > /dev/null
                echo "Starting Video Wallpaper..."
                # Added --hwdec=auto-safe to prevent libcuda errors
                nohup mpvpaper -o "no-audio --loop --hwdec=auto-safe" $MONITOR $VIDEO_WALLPAPER >/dev/null 2>&1 &
                disown
            end
        else
            # BATTERY MODE (Unplugged)
            if pgrep -f "mpvpaper" > /dev/null
                echo "Stopping Video Wallpaper..."
                killall mpvpaper
            end
        end
        
        sleep 5
    end
end