function wgnord_status
    # Check if the interface 'wgnord' exists
    if ip link show wgnord > /dev/null 2>&1
        # Connected: Locked icon (Green/Active class)
        echo '{"text": "", "tooltip": "VPN Connected", "class": "connected", "alt": "connected"}'
    else
        # Disconnected: Unlocked icon (Red/Inactive class)
        echo '{"text": "", "tooltip": "VPN Disconnected", "class": "disconnected", "alt": "disconnected"}'
    end
end