function wgnord_toggle
    if ip link show wgnord > /dev/null 2>&1
        notify-send "NordVPN" "Disconnecting..."
        sudo systemctl stop wgnord
    else
        notify-send "NordVPN" "Connecting..."
        sudo systemctl start wgnord
    end
end