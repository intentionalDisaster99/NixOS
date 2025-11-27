function power_save_toggle
    set current_profile (powerprofilesctl get)

    if test "$current_profile" = "balanced"
        # Balanced -> Eco Mode
        # Turn OFF effects, set to Power Saver
        hyprctl --batch "\
            keyword decoration:blur:enabled 0;\
            keyword decoration:shadow:enabled 0;\
            keyword animations:enabled 0"
        powerprofilesctl set power-saver
        notify-send -u low "🔋 Eco Mode" "Visuals OFF | CPU Low"

    else if test "$current_profile" = "power-saver"
        # Eco Mode -> Performance Mode
        # Turn ON effects, set to Performance
        hyprctl --batch "\
            keyword decoration:blur:enabled 1;\
            keyword decoration:shadow:enabled 1;\
            keyword animations:enabled 1"
        powerprofilesctl set performance
        notify-send -u low "🚀 Performance Mode" "Visuals ON | CPU Max"

    else
        # Performance/Unknown -> Balanced Mode
        # Turn ON effects, set to Balanced
        hyprctl --batch "\
            keyword decoration:blur:enabled 1;\
            keyword decoration:shadow:enabled 1;\
            keyword animations:enabled 1"
        powerprofilesctl set balanced
        notify-send -u low "⚖️ Balanced Mode" "Visuals ON | CPU Normal"
    end
end