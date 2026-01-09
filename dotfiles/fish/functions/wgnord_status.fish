function wgnord_status
    # Check if the interface 'wgnord' exists
    if ip link show wgnord > /dev/null 2>&1
        echo '{"text": "", "tooltip": "VPN Connected", "class": "connected", "alt": "connected"}'
    else
        echo '{"text": "", "tooltip": "VPN Disconnected", "class": "disconnected", "alt": "disconnected"}'
    end
end