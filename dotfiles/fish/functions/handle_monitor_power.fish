function handle_monitor_power
    set LOG "/tmp/wall_debug.log"
    set PID_FILE "/tmp/mpvpaper.pid"
    
    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "*" 
    set CPU_LIMIT 80

    # --- 1. CLEANUP CONFLICTS ---
    # Critical: Kill the static wallpaper daemon so it doesn't block the video
    killall -q hyprpaper
    
    # Kill old mpvpaper instances
    if test -f $PID_FILE
        set OLD_PID (cat $PID_FILE)
        if test -n "$OLD_PID"
            kill $OLD_PID 2>/dev/null
        end
        rm $PID_FILE
    end
    killall -q mpvpaper 
    sleep 1

    # Initialize CPU stats
    set cpu_line (grep '^cpu ' /proc/stat)
    set cpu_str (string trim (string replace -r '^cpu\s+' '' (string replace -r -a '\s+' ' ' $cpu_line)))
    set vals (string split " " $cpu_str)
    set PREV_TOTAL 0
    for v in $vals; set PREV_TOTAL (math $PREV_TOTAL + $v); end
    set PREV_IDLE $vals[4]

    while true
        # --- 2. CPU CALCULATION ---
        set cpu_line (grep '^cpu ' /proc/stat)
        set cpu_str (string trim (string replace -r '^cpu\s+' '' (string replace -r -a '\s+' ' ' $cpu_line)))
        set vals (string split " " $cpu_str)
        set CURRENT_TOTAL 0
        for v in $vals; set CURRENT_TOTAL (math $CURRENT_TOTAL + $v); end
        set CURRENT_IDLE $vals[4]
        set DIFF_TOTAL (math $CURRENT_TOTAL - $PREV_TOTAL)
        set DIFF_IDLE (math $CURRENT_IDLE - $PREV_IDLE)
        if test $DIFF_TOTAL -gt 0
            set CPU_USAGE (math -s0 "100 * ($DIFF_TOTAL - $DIFF_IDLE) / $DIFF_TOTAL")
        else
            set CPU_USAGE 0
        end
        set PREV_TOTAL $CURRENT_TOTAL
        set PREV_IDLE $CURRENT_IDLE

        # --- 3. POWER CHECK ---
        # Using the sensor we confirmed works: ADP1
        if test -e /sys/class/power_supply/ADP1/online
            set ADAPTER_RAW (cat /sys/class/power_supply/ADP1/online)
        else
            set ADAPTER_RAW "1" # Fallback to ON
        end

        # --- 4. ACTION ---
        if test "$ADAPTER_RAW" = "1"; and test $CPU_USAGE -lt $CPU_LIMIT
            
            # CHECK IF RUNNING
            set IS_RUNNING 0
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                if kill -0 $CURRENT_PID 2>/dev/null
                    set IS_RUNNING 1
                else
                    rm $PID_FILE
                end
            end

            if test "$IS_RUNNING" = "0"
                # START IT
                # Removed '--fps' (invalid)
                # Kept '--hwdec=no' (Stable CPU decoding)
                # Kept '--profile=fast' (Low resource usage)
                nohup mpvpaper -o "no-audio --loop-file=inf --profile=fast --hwdec=no" $MONITOR $VIDEO_WALLPAPER >/dev/null 2>&1 &
                
                set NEW_PID $last_pid
                echo $NEW_PID > $PID_FILE
            end
        else
            # STOP IT (Battery or High CPU)
            if test -f $PID_FILE
                set CURRENT_PID (cat $PID_FILE)
                kill $CURRENT_PID 2>/dev/null
                rm $PID_FILE
            end
        end
        
        sleep 5
    end
end