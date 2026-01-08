function autostart
    # Start basic services (one per line is safer)
    hypridle & 
    dunst & 
    pypr & 
    poweralertd -s & 
    avizo-service & 
    
    # Clipboard managers
    wl-paste --type text --watch cliphist store & 
    wl-paste --type image --watch cliphist store & 
    wl-clip-persist --clipboard regular & 
    
    # Static wallpaper (Safe fallback)
    hyprpaper & 
    
    # Notifications
    systemctl --user start psi-notify &
    
    # Wait for things to settle
    sleep 2

    # Save power by stopping video wallpaper if power mode changes
    # handle_monitor_power & 

    # Making my mouse disappear if not being used
    unclutter & 

    # Start Waybar last
    waybar &
end