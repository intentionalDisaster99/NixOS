function check_power_save
    set current_profile (powerprofilesctl get)

    if test "$current_profile" = "power-saver"
        echo '{ "text":"󰌪", "tooltip": "Mode: Eco", "class": "eco" }'
    else if test "$current_profile" = "performance"
        echo '{ "text":"󰓅", "tooltip": "Mode: Performance", "class": "performance" }'
    else
        # Default to Balanced
        echo '{ "text":"󰁹", "tooltip": "Mode: Balanced", "class": "balanced" }'
    end
end