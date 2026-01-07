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

    # 1. CLEANUP OLD INSTANCES
    echo "Killing old instances..." >> $LOG
    killall -q mpvpaper 
    sleep 1

    # State tracking to prevent log spam
    set LAST_STATE "unknown"

    while true
        # 2. ECO MODE CHECK
        if test -f /tmp/eco_mode
            # Only kill if running
            if pgrep -x "mpvpaper" > /dev/null
                echo "Eco Mode detected. Killing video." >> $LOG
                killall -q mpvpaper
            end
            
            # Log this only once to avoid spam
            if test "$LAST_STATE" != "eco"
                echo "Entered Eco Mode (paused)." >> $LOG
                set LAST_STATE "eco"
            end
            
            sleep 5
            continue
        end

        # 3. POWER STATUS CHECK
        set ADAPTER_RAW (cat /sys/class/power_supply/ADP1/online 2>/dev/null)
        
        # Logic: If '1', AC. If '0', Battery. Default to AC.
        if test "$ADAPTER_RAW" = "0"
            set POWER_STATUS "0"
        else
            set POWER_STATUS "1"
        end

        # 4. ACTION
        if test "$POWER_STATUS" = "1"
            # --- AC MODE ---
            # Check if running using -x (EXACT MATCH)
            if pgrep -x "mpvpaper" > /dev/null
                # Already running, do nothing
                if test "$LAST_STATE" != "running"
                     echo "AC Mode: Video confirmed running." >> $LOG
                     set LAST_STATE "running"
                end
            else
                echo "AC Mode Detected: Starting mpvpaper..." >> $LOG
                
                # Launch
                nohup mpvpaper -o "no-audio --loop --hwdec=auto-safe" $MONITOR $VIDEO_WALLPAPER >/tmp/mpv_error.log 2>&1 &
                disown
                
                sleep 1
                if pgrep -x "mpvpaper" > /dev/null
                    echo "SUCCESS: mpvpaper launched." >> $LOG
                    set LAST_STATE "running"
                else
                    echo "FAILURE: mpvpaper crashed. Check /tmp/mpv_error.log" >> $LOG
                    set LAST_STATE "failed"
                end
            end

        else
            # --- BATTERY MODE ---
            if pgrep -x "mpvpaper" > /dev/null
                echo "Battery Mode Detected: Killing video." >> $LOG
                killall -q mpvpaper
                set LAST_STATE "killed"
            else
                 # Prevent spam if already killed
                 if test "$LAST_STATE" != "battery_idle"
                     echo "Battery Mode: Video is off." >> $LOG
                     set LAST_STATE "battery_idle"
                 end
            end
        end
        
        sleep 5
    end
end