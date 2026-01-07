function handle_monitor_power
    set LOG "/tmp/wall_debug.log"
    echo "--- Script Starting at $(date) ---" > $LOG

    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "eDP-1" 

    echo "Target Monitor: $MONITOR" >> $LOG
    echo "Video Path: $VIDEO_WALLPAPER" >> $LOG

    # 0. Verify file existence
    if test -f $VIDEO_WALLPAPER
        echo "Video file confirmed found." >> $LOG
    else
        echo "CRITICAL ERROR: Video file NOT found at $VIDEO_WALLPAPER" >> $LOG
    end

    # 1. CLEANUP
    echo "Killing old instances..." >> $LOG
    killall mpvpaper 2>/dev/null
    sleep 1

    while true
        # 2. ECO MODE CHECK
        if test -f /tmp/eco_mode
            echo "Eco Mode detected (/tmp/eco_mode exists). Video forced OFF." >> $LOG
            if pgrep -f "mpvpaper" > /dev/null
                killall mpvpaper
            end
            sleep 5
            continue
        end

        # 3. POWER STATUS CHECK
        # We try to read ADP1. If empty, we log it.
        set ADAPTER_RAW (cat /sys/class/power_supply/ADP1/online 2>/dev/null)
        echo "Power Sensor (ADP1) says: '$ADAPTER_RAW'" >> $LOG

        # Logic: If '1', AC. If '0', Battery. If empty, assume AC (fail-safe).
        if test "$ADAPTER_RAW" = "1"
            set POWER_STATUS "1"
        else if test "$ADAPTER_RAW" = "0"
            set POWER_STATUS "0"
        else
            echo "Sensor read failed/empty. Defaulting to AC." >> $LOG
            set POWER_STATUS "1"
        end

        # 4. ACTION
        if test "$POWER_STATUS" = "1"
            # AC MODE
            if pgrep -f "mpvpaper" > /dev/null
                # It is running, do nothing (commented out to reduce log spam)
                # echo "AC Mode: Video is running." >> $LOG
            else
                echo "AC Mode Detected: Starting mpvpaper..." >> $LOG
                
                # We log the launch output to a separate error log for details
                nohup mpvpaper -o "no-audio --loop --hwdec=auto-safe" $MONITOR $VIDEO_WALLPAPER >/tmp/mpv_error.log 2>&1 &
                disown
                
                # Immediate check to see if it crashed
                sleep 1
                if pgrep -f "mpvpaper" > /dev/null
                    echo "SUCCESS: mpvpaper launched successfully." >> $LOG
                else
                    echo "FAILURE: mpvpaper started but crashed immediately. Check /tmp/mpv_error.log" >> $LOG
                end
            end
        else
            # BATTERY MODE
            if pgrep -f "mpvpaper" > /dev/null
                echo "Battery Mode Detected: Killing video." >> $LOG
                killall mpvpaper
            end
        end
        
        sleep 5
    end
end