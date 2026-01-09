function wgnord_status
    # Check if the interface 'wgnord' exists
    if ip link show wgnord > /dev/null 2>&1
        echo '{"text": "\uf023", "tooltip": "VPN Connected", "class": "connected", "alt": "connected"}'
    else
        echo '{"text": "\uf09c", "tooltip": "VPN Disconnected", "class": "disconnected", "alt": "disconnected"}'
    end
end