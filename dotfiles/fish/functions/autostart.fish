function autostart

    # Static wallpaper in the background
    # hyprpaper & 
    hyprpaper -c /etc/nixos/dotfiles/hypr/hyprpaper.conf &

    # Start basic services 
    hypridle &
    dunst & 
    # pypr & 
    pypr --config /etc/nixos/dotfiles/hypr/pyprland.toml &
    poweralertd -s & 
    avizo-service & 
    emote &
    
    # Clipboard managers
    wl-paste --type text --watch cliphist store & 
    wl-paste --type image --watch cliphist store & 
    wl-clip-persist --clipboard regular & 
    
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

    # Now for random stuff that we need to start dependent on the host
    switch $hostname
        case higgs-boson
            autostart-higgs-boson
        case gluon
            autostart-gluon
        case '*'
            notify-send Host not accounted for in my fish autostart function
    end

    # Automatically lock (only needed if autoLogin is enabled)
    # sleep 0.25
    hyprlock &

end