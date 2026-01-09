function wgnord_status
    if systemctl is-active --quiet wg-quick-wgnord
        # JSON output for Waybar: Locked icon when connected
        echo '{"text": "", "tooltip": "VPN Connected", "class": "connected", "alt": "connected"}'
    else
        # Unlocked icon when disconnected
        echo '{"text": "", "tooltip": "VPN Disconnected", "class": "disconnected", "alt": "disconnected"}'
    end
end