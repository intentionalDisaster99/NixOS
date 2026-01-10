function handle_monitor_power
    set LOG "/tmp/wall_debug.log"
    set PID_FILE "/tmp/mpvpaper.pid"
    
    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "*"
    
    # Threshold: Pauses if CPU usage is above this %
    set CPU_LIMIT 80

    # --- INITIALIZE CPU STATS ---
    # We take a baseline reading so our first loop calculates a real delta
    set cpu_line (grep '^cpu ' /proc/stat)
    # Clean up the string (remove 'cpu' prefix and normalize spaces)
    set cpu_str (string trim (string replace -r '^cpu\s+' '' (string replace -r -a '\s+' ' ' $cpu_line)))
    set vals (string split " " $cpu_str)
    
    set PREV_TOTAL 0
    for v in $vals
        set PREV_TOTAL (math $PREV_TOTAL + $v)
    end
    set PREV_IDLE $vals[4] # 4th value is idle time

    # Cleanup old instances on start
    if test -f $PID_FILE
        set OLD_PID (cat $PID_FILE)
        if test -n "$OLD_PID"
            kill $OLD_PID 2>/dev/null
        end
        rm $PID_FILE
    end
    killall -q mpvpaper 
    sleep 1

    set LAST_STATE "unknown"

    while true
        # 1. ECO MODE CHECK (Manual Override)
        if test -f /tmp/eco_mode
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                kill $CURRENT_PID 2>/dev/null
                rm $PID_FILE
                echo "Eco Mode: Killed video PID $CURRENT_PID" >> $LOG
            end
            # We still sleep to prevent a busy loop, but we skip the math
            sleep 5
            continue
        end

        # 2. CALCULATE CPU USAGE (Avg over last 5 seconds)
        set cpu_line (grep '^cpu ' /proc/stat)
        set cpu_str (string trim (string replace -r '^cpu\s+' '' (string replace -r -a '\s+' ' ' $cpu_line)))
        set vals (string split " " $cpu_str)
        
        set CURRENT_TOTAL 0
        for v in $vals
            set CURRENT_TOTAL (math $CURRENT_TOTAL + $v)
        end
        set CURRENT_IDLE $vals[4]

        set DIFF_TOTAL (math $CURRENT_TOTAL - $PREV_TOTAL)
        set DIFF_IDLE (math $CURRENT_IDLE - $PREV_IDLE)

        # Avoid divide by zero
        if test $DIFF_TOTAL -gt 0
            set CPU_USAGE (math -s0 "100 * ($DIFF_TOTAL - $DIFF_IDLE) / $DIFF_TOTAL")
        else
            set CPU_USAGE 0
        end

        # Update previous values for next loop
        set PREV_TOTAL $CURRENT_TOTAL
        set PREV_IDLE $CURRENT_IDLE

        # 3. POWER STATUS CHECK
        set ADAPTER_RAW (cat /sys/class/power_supply/ADP1/online 2>/dev/null)
        if test "$ADAPTER_RAW" = "0"
            set POWER_STATUS "0"
        else
            set POWER_STATUS "1"
        end

        # 4. DECISION LOGIC
        # Run ONLY if: (AC Connected) AND (CPU < Limit)
        if test "$POWER_STATUS" = "1"; and test $CPU_USAGE -lt $CPU_LIMIT
            
            # --- START / RESUME ---
            set IS_RUNNING 0
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                if kill -0 $CURRENT_PID 2>/dev/null
                    set IS_RUNNING 1
                else
                    rm $PID_FILE
                end
            end

            if test "$IS_RUNNING" = "1"
                # Just logging status occasionally
                if test "$LAST_STATE" != "running"
                     echo "Resuming: AC Connected & CPU OK ($CPU_USAGE%)." >> $LOG
                     set LAST_STATE "running"
                end
            else
                echo "Starting: AC Connected & CPU OK ($CPU_USAGE%)." >> $LOG
                nohup mpvpaper -o "no-audio --loop-file=inf --profile=fast --hwdec=no --fps=30" $MONITOR $VIDEO_WALLPAPER >/tmp/mpv_error.log 2>&1 &
                set NEW_PID $last_pid
                echo $NEW_PID > $PID_FILE
                set LAST_STATE "running"
            end

        else
            # --- STOP / PAUSE ---
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                
                # Log the reason for stopping
                if test "$POWER_STATUS" = "0"
                    echo "Stopping: Battery Mode ($CPU_USAGE% CPU)" >> $LOG
                else
                    echo "Stopping: High CPU Load ($CPU_USAGE% > $CPU_LIMIT%)" >> $LOG
                end
                
                kill $CURRENT_PID 2>/dev/null
                rm $PID_FILE
                set LAST_STATE "killed"
            end
        end
        
        # Wait 5 seconds before checking again
        # This creates the "window" for our CPU average
        sleep 5
    end
end