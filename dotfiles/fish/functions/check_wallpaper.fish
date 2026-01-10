function check_wallpaper
    set MODE_FILE "/tmp/wallpaper_mode"
    
    if test -f $MODE_FILE
        set MODE (cat $MODE_FILE)
    else
        set MODE "normal"
    end

    switch $MODE
        case "forced"
            # Icon: Fire/High Energy (Always On)
            printf '{"text": "🔥", "tooltip": "Moving Wallpaper: Forced", "class": "forced", "alt": "forced"}\n'
        case "off"
            # Icon: Sleep/Moon (Always Off)
            printf '{"text": "💤", "tooltip": "Moving Wallpaper: Off", "class": "off", "alt": "off"}\n'
        case "*" 
            # Normal: Robot/Brain (Smart Automation)
            printf '{"text": "🤖", "tooltip": "Moving Wallpaper: Auto", "class": "normal", "alt": "normal"}\n'
    end
end