function steno_toggle
    set MODE_FILE "/tmp/steno_mode"

    # Defaulting to inactive
    if not test -f $MODE_FILE
        echo "normal" > $MODE_FILE
    end

    # Creating plover
    if not pgrep -f plover > /dev/null
        command plover -g none
    end

    set CURRENT (cat $MODE_FILE)

    if test "$CURRENT" = "steno"
        echo "normal" > $MODE_FILE
        plover -s plover_send_command suspend
        notify-send -u low -t 2000 "Steno turned off."
    else if test "$CURRENT" = "normal"
        echo "steno" > $MODE_FILE
        plover -s plover_send_command resume
        notify-send -u low -t 2000 "Steno turned on."
    end
     
end