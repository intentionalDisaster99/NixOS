function wgnord_toggle
    if systemctl is-active --quiet wg-quick-wgnord
        notify-send "NordVPN" "Disconnecting"
        # This will trigger your GUI password prompt (Polkit)
        # systemctl stop wg-quick-wgnord
        wgnord d
    else
        notify-send "NordVPN" "Connecting to United States"
        # systemctl start wg-quick-wgnord
        wgnord c "United States"
    end
end