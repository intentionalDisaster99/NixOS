function wgnord_toggle
    if ip link show wgnord > /dev/null 2>&1
        notify-send "NordVPN" "Disconnecting..."
        # We stop the service to cleanly remove the interface/DNS
        sudo systemctl stop wg-quick-wgnord
    else
        notify-send "NordVPN" "Connecting..."
        # We start the service to generate config and connect
        sudo systemctl start wg-quick-wgnord
    end
end