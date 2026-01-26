function power_save_toggle
    if test -f /tmp/eco_mode
        rm /tmp/eco_mode
        notify-send -u low "Eco Mode: OFF" "Video wallpaper enabled (if plugged in)"
    else
        touch /tmp/eco_mode
        notify-send -u low "Eco Mode: ON" "Video wallpaper disabled"
    end
    # Refresh the waybar module immediately
    pkill -SIGRTMIN+8 waybar
end