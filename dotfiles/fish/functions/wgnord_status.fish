function wgnord_status
    if ip link show wgnord > /dev/null 2>&1
        # Connected: Use the 'Locked' icon from your keyboard module (󰌾)
        printf '{"text": "󰌾", "tooltip": "VPN Connected", "class": "connected", "alt": "connected"}\n'
    else
        # Disconnected: Use the 'Unlocked' icon from your keyboard module (󰍀)
        printf '{"text": "󰍀", "tooltip": "VPN Disconnected", "class": "disconnected", "alt": "disconnected"}\n'
    end
end