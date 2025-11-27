function check_power_save
    # Check the blur status. 'int: 1' means enabled (Balanced), 'int: 0' means disabled (Eco)
    set status (hyprctl getoption decoration:blur:enabled | grep 'int: 1')

    if test -n "$status"
        # Blur is ENABLED (1) -> Power Save is OFF (Normal Mode)
        echo '{ "text":"󰁹", "tooltip": "power-save <span color=\'#ee99a0\'>off</span>", "class": "off" }'
    else
        # Blur is DISABLED (0) -> Power Save is ON (Eco Mode)
        echo '{ "text":"󱈏", "tooltip": "power-save <span color=\'#a6da95\'>on</span>", "class": "on" }'
    end
end