function check_power_save
    # Check if blur is currently enabled (1) or disabled (0)
    set current_state (hyprctl getoption decoration:blur:enabled | awk '/int:/ {print $2}')

    if test "$current_state" -eq 0
        # Blur is OFF -> Power Save is ON
        echo '{ "text":"󱈏", "tooltip": "power-save <span color=\'#a6da95\'>on</span>", "class": "on" }'
    else
        # Blur is ON -> Power Save is OFF
        echo '{ "text":"󰁹", "tooltip": "power-save <span color=\'#ee99a0\'>off</span>", "class": "off" }'
    end
end