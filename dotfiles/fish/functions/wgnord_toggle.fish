function wgnord_toggle
    if systemctl is-active --quiet wg-quick-wgnord
        notify-send "NordVPN" "Disconnecting..."
        # This will trigger your GUI password prompt (Polkit)
        systemctl stop wg-quick-wgnord
    else
        notify-send "NordVPN" "Connecting..."
        systemctl start wg-quick-wgnord
    end
end