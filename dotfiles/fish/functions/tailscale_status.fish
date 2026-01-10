function tailscale_status
    # 1. Check if Tailscale is running at all
    # We use 'tailscale status' which fails if the daemon is stopped
    if not command -v tailscale > /dev/null; or not tailscale status > /dev/null 2>&1
        printf '{"text": "○", "tooltip": "Tailscale Stopped", "class": "disconnected", "alt": "disconnected"}\n'
        return
    end

    # 2. Count "active" peers (devices you are actually exchanging data with)
    set -l active_count (tailscale status | grep -c "active;")

    # 3. Output
    if test $active_count -gt 0
        # Connected + Active Peers: Show Count (e.g., "🌐 2")
        printf '{"text": " %s", "tooltip": "Tailscale: %s Active Peers", "class": "connected", "alt": "connected"}\n' "$active_count" "$active_count"
    else
        # Connected but Idle: Just the Globe
        printf '{"text": "󰌙 0", "tooltip": "Tailscale: Running (Idle)", "class": "connected", "alt": "connected"}\n'
    end
end