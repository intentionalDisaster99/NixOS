# This runs on startup every time that hyprland starts
function autostart

    # Making my bluetooth stuff work
    mpris-proxy & disown

    # Starting my scratchpads
    pypr & disown

    # Locking the device
    sleep 1
    noctalia-shell ipc call lockScreen lock

end