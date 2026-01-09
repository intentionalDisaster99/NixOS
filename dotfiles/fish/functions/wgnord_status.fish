function wgnord_toggle
    # Check if the interface exists
    if ip link show wgnord > /dev/null 2>&1
        notify-send "NordVPN" "Disconnecting..."
        # Stop the correct service name
        sudo systemctl stop wgnord
    else
        notify-send "NordVPN" "Connecting..."
        # Start the correct service name
        sudo systemctl start wgnord
    end
end