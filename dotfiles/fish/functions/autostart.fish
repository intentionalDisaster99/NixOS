function autostart
    powerprofilesctl set balanced &
    hypridle & dunst & pypr & poweralertd -s & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store & wl-clip-persist --clipboard regular & avizo-service & hyprpaper & systemctl --user start psi-notify
    sleep 3
    handle_monitor_power
    waybar &
end