function wall_toggle
    set MODE_FILE "/tmp/wallpaper_mode"

    if not test -f $MODE_FILE
        echo "off" > $MODE_FILE
    end

    set CURRENT (cat $MODE_FILE)

    if test "$CURRENT" = "normal"
        echo "forced" > $MODE_FILE
        notify-send -u low -t 2000 "Wallpaper: FORCED ON" "Ignoring Battery & CPU"
    else if test "$CURRENT" = "forced"
        echo "off" > $MODE_FILE
        notify-send -u low -t 2000 "Wallpaper: OFF" "Saving Power"
    else
        echo "normal" > $MODE_FILE
        notify-send -u low -t 2000 "Wallpaper: NORMAL" "Smart Power/CPU Saving"
    end
    
    
end