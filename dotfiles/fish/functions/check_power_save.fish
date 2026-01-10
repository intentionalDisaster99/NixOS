function check_power_save
    if test -f /tmp/eco_mode
        # JSON for "Enabled" 
        echo '{"text": "󰿎", "tooltip": "Moving Wallpaper On", "class": "active", "alt": "active"}'
    else
        # JSON for "Disabled" 
        echo '{"text": "", "tooltip": "Photo Wallpaper Enabled", "class": "inactive", "alt": "inactive"}'
    end
end