function tailscale_status
    # Ping 100.100.100.100 (Tailscale's internal DNS server)
    # This IP is only reachable if the Tailnet mesh is actually working.
    # -c 1: Send 1 ping
    # -W 1: Wait max 1 second for a reply
    if ping -c 1 -W 1 100.100.100.100 > /dev/null 2>&1
        # Success: We can reach the internal mesh
        printf '{"text": "", "tooltip": "Tailnet Reachable", "class": "connected", "alt": "connected"}\n'
    else
        # Fail: Cannot reach the mesh (Blocked or Stopped)
        printf '{"text": "󰌙", "tooltip": "Tailnet Unreachable", "class": "disconnected", "alt": "disconnected"}\n'
    end
end