function check_power_save
    if test -f /tmp/eco_mode
        # JSON for "Enabled" 
        echo '{"text": "", "tooltip": "Eco Mode: ON", "class": "active", "alt": "active"}'
    else
        # JSON for "Disabled" 
        echo '{"text": "", "tooltip": "Eco Mode: OFF", "class": "inactive", "alt": "inactive"}'
    end
end