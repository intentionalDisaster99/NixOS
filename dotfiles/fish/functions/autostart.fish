function autostart
    powerprofilesctl set balanced &
    hypridle & dunst & pypr & poweralertd -s & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store & wl-clip-persist --clipboard regular & avizo-service & hyprpaper & handle_monitor_power & systemctl --user start psi-notify
    sleep 2
    waybar &
end