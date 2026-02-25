function steno_toggle
    set MODE_FILE "/tmp/steno_mode"

    if not test -f $MODE_FILE
        echo "steno_inactive" > $MODE_FILE
    end

    set CURRENT (cat $MODE_FILE)

    if test "$CURRENT" = "steno_active"
        echo "steno_inactive" > $MODE_FILE
        plover -s plover_send_command suspend
        notify-send -u low -t 2000 "Steno turned off."
    else if test "$CURRENT" = "steno_inactive"
        echo "steno_active" > $MODE_FILE
        plover -s plover_send_command resume
        notify-send -u low -t 2000 "Steno turned on."
    end
     
end