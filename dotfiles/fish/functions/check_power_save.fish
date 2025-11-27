function check_power_save
    # Check the actual system power profile
    if powerprofilesctl get | grep -q "power-saver"
        # Power Saver is ACTIVE -> Eco Mode ON (Green Leaf)
        echo '{ "text":"󱈏", "tooltip": "power-save <span color=\'#a6da95\'>on</span>", "class": "on" }'
    else
        # Balanced/Performance -> Eco Mode OFF (Battery Icon)
        echo '{ "text":"󰁹", "tooltip": "power-save <span color=\'#ee99a0\'>off</span>", "class": "off" }'
    end
end