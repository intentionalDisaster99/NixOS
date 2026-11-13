# This runs on startup every time that hyprland starts
function autostart

    # Making my bluetooth stuff work
    mpris-proxy & disown

    # Starting my scratchpads
    pypr & disown

    # Locking the device
    for i in (seq 1 100)
        if noctalia-shell ipc call lockScreen lock >/dev/null 2>&1
      #      pkill swaybg
            break
        end
        sleep 0.05
    end
    noctalia-shell ipc call lockScreen lock

end
