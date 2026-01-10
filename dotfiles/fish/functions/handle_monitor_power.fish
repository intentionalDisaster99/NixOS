function handle_monitor_power
    echo "--- DEBUG MODE STARTING ---"
    
    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "*"
    
    # 1. Kill old stuff
    echo "Cleaning up old processes..."
    killall -q mpvpaper 
    sleep 1

    echo "Entering loop..."
    while true
        # 2. Check Power Supply (Adjust ADP1 if needed!)
        # We assume 'ADP1'. If 'ls /sys/class/power_supply' showed 'AC', change it here!
        if test -e /sys/class/power_supply/ADP1/online
            set ADAPTER_RAW (cat /sys/class/power_supply/ADP1/online)
            echo "Power Sensor Found: Status = $ADAPTER_RAW"
        else
            echo "ERROR: Power sensor /sys/class/power_supply/ADP1/online not found!"
            set ADAPTER_RAW "1" # Default to ON so we can at least see if video plays
        end

        # 3. Attempt to Start
        if test "$ADAPTER_RAW" = "1"
            echo "Status: AC Connected. Starting Wallpaper..."
            
            # Run in foreground for 5 seconds to test, then loop
            # We use --profile=fast and NO hardware decoding for maximum safety
            mpvpaper -o "no-audio --loop-file=inf --profile=fast --hwdec=no --fps=30" $MONITOR $VIDEO_WALLPAPER &
            set PID $last_pid
            echo "Wallpaper started with PID: $PID"
            
            # Wait 10 seconds then kill it (just for this test)
            sleep 10
            echo "Test cycle done. Killing PID $PID..."
            kill $PID
            break # Stop after one run
        else
            echo "Status: Battery Mode (Skipping Wallpaper)"
            break
        end
    end
    echo "--- DEBUG FINISHED ---"
end