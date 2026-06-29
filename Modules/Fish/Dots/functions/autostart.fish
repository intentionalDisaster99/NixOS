# This runs on startup every time that hyprland starts
function autostart

    # Making my bluetooth stuff work
    mpris-proxy &

    # Starting my scratchpads
    pypr &

    # Locking the device
    noctalia-shell ipc call lockScreen lock

end