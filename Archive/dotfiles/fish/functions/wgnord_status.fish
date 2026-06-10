function wgnord_status
    if ip link show wgnord > /dev/null 2>&1
        printf '{"text": "󰌾", "tooltip": "VPN Connected", "class": "connected", "alt": "connected"}\n'
    else
        printf '{"text": "󰍀", "tooltip": "VPN Disconnected", "class": "disconnected", "alt": "disconnected"}\n'
    end
end