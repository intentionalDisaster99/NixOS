function autostart

    # Automatically lock
    hyprlock &

    # Start basic services 
    hypridle & 
    dunst & 
    pypr & 
    poweralertd -s & 
    avizo-service & 
    emote &
    
    # Clipboard managers
    wl-paste --type text --watch cliphist store & 
    wl-paste --type image --watch cliphist store & 
    wl-clip-persist --clipboard regular & 
    
    # Static wallpaper in the background
    hyprpaper & 
    
    # Notifications
    systemctl --user start psi-notify &

    # Video wallpaper sometimes
    fish -c "handle_wallpaper" &

    # Making my mouse disappear if not being used
    unclutter & 
    
    # Starting the ssh agent (because I've had some issues with it not starting)
    eval $(ssh-agent -s) 

    # Wait for things to settle
    sleep 0.5

    # Start Waybar last
    waybar > /tmp/waybar.log 2>&1
end