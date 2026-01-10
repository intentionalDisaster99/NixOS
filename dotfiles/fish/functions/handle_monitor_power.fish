function handle_monitor_power
    set PID_FILE "/tmp/mpvpaper.pid"
    set MODE_FILE "/tmp/wallpaper_mode"
    
    # Configuration
    set VIDEO_WALLPAPER "/etc/nixos/resources/wallpapers/car.mp4" 
    set MONITOR "*" 
    set CPU_LIMIT 80

    # Ensure we start in Normal mode if no file exists
    if not test -f $MODE_FILE
        echo "normal" > $MODE_FILE
    end

    # Clean start
    killall -q hyprpaper
    killall -q mpvpaper
    rm -f $PID_FILE

    # CPU Stats Initialization
    set cpu_line (grep '^cpu ' /proc/stat)
    set cpu_str (string trim (string replace -r '^cpu\s+' '' (string replace -r -a '\s+' ' ' $cpu_line)))
    set vals (string split " " $cpu_str)
    set PREV_TOTAL 0
    for v in $vals; set PREV_TOTAL (math $PREV_TOTAL + $v); end
    set PREV_IDLE $vals[4]

    while true
        # 1. READ CURRENT MODE
        if test -f $MODE_FILE
            set MODE (cat $MODE_FILE)
        else
            set MODE "normal"
        end

        # 2. DETERMINE DESIRED STATE (Should it be running?)
        set SHOULD_RUN 0

        if test "$MODE" = "off"
            set SHOULD_RUN 0
        else if test "$MODE" = "forced"
            set SHOULD_RUN 1
        else
            # --- NORMAL MODE LOGIC (Smart) ---
            
            # A. Calculate CPU
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

            # B. Check Power (Default to 1 if sensor fails)
            if test -e /sys/class/power_supply/ADP1/online
                set ADAPTER (cat /sys/class/power_supply/ADP1/online)
            else
                set ADAPTER 1
            end

            # C. Decision
            if test "$ADAPTER" = "1"; and test $CPU_USAGE -lt $CPU_LIMIT
                set SHOULD_RUN 1
            else
                set SHOULD_RUN 0
            end
        end

        # 3. APPLY STATE
        # Check if it is currently running
        set IS_RUNNING 0
        if test -f $PID_FILE
            set CURRENT_PID (cat $PID_FILE)
            if kill -0 $CURRENT_PID 2>/dev/null
                set IS_RUNNING 1
            else
                rm $PID_FILE
            end
        end

        if test "$SHOULD_RUN" = "1"
            if test "$IS_RUNNING" = "0"
                # START IT
                # Using nohup and disown to ensure it survives correctly
                nohup mpvpaper -o "no-audio --loop-file=inf --profile=fast --hwdec=no" $MONITOR $VIDEO_WALLPAPER >/dev/null 2>&1 &
                set NEW_PID $last_pid
                echo $NEW_PID > $PID_FILE
                disown
            end
        else
            if test "$IS_RUNNING" = "1"
                # KILL IT
                kill $CURRENT_PID 2>/dev/null
                rm $PID_FILE
            end
        end

        sleep 5
    end
end