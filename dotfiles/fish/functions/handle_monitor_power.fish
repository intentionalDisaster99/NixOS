function handle_monitor_power
    set LOG "/tmp/wall_debug.log"
    set PID_FILE "/tmp/mpvpaper.pid"
    
    echo "--- Script Starting at $(date) ---" > $LOG

    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "eDP-1" 

    # 1. CLEANUP OLD INSTANCES
    if test -f $PID_FILE
        set OLD_PID (cat $PID_FILE)
        if test -n "$OLD_PID"
            kill $OLD_PID 2>/dev/null
        end
        rm $PID_FILE
    end
    # Fallback cleanup just in case
    killall -q mpvpaper 
    sleep 1

    set LAST_STATE "unknown"

    while true
        # 2. ECO MODE CHECK
        if test -f /tmp/eco_mode
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                kill $CURRENT_PID 2>/dev/null
                rm $PID_FILE
                echo "Eco Mode: Killed video PID $CURRENT_PID" >> $LOG
            end
            sleep 5
            continue
        end

        # 3. POWER STATUS CHECK
        set ADAPTER_RAW (cat /sys/class/power_supply/ADP1/online 2>/dev/null)
        if test "$ADAPTER_RAW" = "0"
            set POWER_STATUS "0"
        else
            set POWER_STATUS "1"
        end

        # 4. ACTION
        if test "$POWER_STATUS" = "1"
            # --- AC MODE ---
            # Check if running by looking for the PID file AND verifying the process exists
            set IS_RUNNING 0
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                # 'kill -0' checks if a process exists without killing it
                if kill -0 $CURRENT_PID 2>/dev/null
                    set IS_RUNNING 1
                else
                    # PID file exists but process is dead (stale file)
                    rm $PID_FILE
                end
            end

            if test "$IS_RUNNING" = "1"
                if test "$LAST_STATE" != "running"
                     echo "AC Mode: Video running (PID $CURRENT_PID)." >> $LOG
                     set LAST_STATE "running"
                end
            else
                echo "AC Mode: Starting mpvpaper..." >> $LOG
                
                # Launch with optimized flags
                # Removed hwdec, added software decoding just to get it stable first
                nohup mpvpaper -o "no-audio --loop-file=inf --vd-lavc-threads=4" $MONITOR $VIDEO_WALLPAPER >/tmp/mpv_error.log 2>&1 &
                
                # CAPTURE THE PID IMMEDIATELY
                set NEW_PID $last_pid
                echo $NEW_PID > $PID_FILE
                
                sleep 1
                if kill -0 $NEW_PID 2>/dev/null
                    echo "SUCCESS: Launched with PID $NEW_PID" >> $LOG
                    set LAST_STATE "running"
                else
                    echo "FAILURE: Process $NEW_PID died immediately." >> $LOG
                    set LAST_STATE "failed"
                end
            end

        else
            # --- BATTERY MODE ---
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                echo "Battery Mode: Killing PID $CURRENT_PID" >> $LOG
                kill $CURRENT_PID 2>/dev/null
                rm $PID_FILE
                set LAST_STATE "killed"
            end
        end
        
        sleep 5
    end
end