function tailscale_status
    # Get the raw status in JSON format (fast and detailed)
    set -l output (tailscale status --json 2>/dev/null)

    # Check if the BackendState is specifically "Running"
    # This confirms the daemon is active, logged in, and the interface is up.
    if string match -q '*"BackendState":"Running"*' -- (string replace -a ' ' '' "$output")
        # Connected: World/Network Emoji
        printf '{"text": "", "tooltip": "Tailscale: Running", "class": "connected", "alt": "connected"}\n'
    else
        # Disconnected: Hollow Circle
        printf '{"text": "󰌙", "tooltip": "Tailscale: Stopped/Idle", "class": "disconnected", "alt": "disconnected"}\n'
    end
end