function tailscale_status
    # We use 'netcheck' to actively test the connection.
    # --brief gives a one-line summary.
    # timeout 2s prevents Waybar from freezing if the network is totally dead.
    set -l output (timeout 2s tailscale netcheck --brief 2>/dev/null)

    # Check if the output explicitly says IPv4 is working
    if string match -q "*IPv4: yes*" -- "$output"
        printf '{"text": "", "tooltip": "Tailscale Online\n%s", "class": "connected", "alt": "connected"}\n' "$output"
    else
        printf '{"text": "󰌙", "tooltip": "Tailscale Offline/Blocked", "class": "disconnected", "alt": "disconnected"}\n'
    end
end