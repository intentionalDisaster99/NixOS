function steno_toggle
    set MODE_FILE "/tmp/steno_mode"

    # Defaulting to inactive
    if not test -f $MODE_FILE
        echo "normal" > $MODE_FILE
    end

    set CURRENT (cat $MODE_FILE)

    if test "$CURRENT" = "steno"
        echo "normal" > $MODE_FILE
        dbus-send --session --type=method_call --dest=org.plover_steno.Plover /org/plover_steno/Plover org.plover_steno.Plover.Suspend
        notify-send -u low -t 2000 "Steno turned off."
    else if test "$CURRENT" = "normal"
        echo "steno" > $MODE_FILE
        dbus-send --session --type=method_call --dest=org.plover_steno.Plover /org/plover_steno/Plover org.plover_steno.Plover.Resume
        notify-send -u low -t 2000 "Steno turned on."
    end
end