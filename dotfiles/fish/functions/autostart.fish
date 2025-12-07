function autostart
    powerprofilesctl set balanced &
    hypridle & dunst & pypr & hyprpaper & poweralertd -s & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store & wl-clip-persist --clipboard regular & avizo-service & systemctl --user start psi-notify
    sleep 2
    waybar &
end