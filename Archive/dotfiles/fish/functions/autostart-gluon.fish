function autostart-gluon

    # Starting my gaming server automatically
    systemctl --user restart sunshine &

    notify-send "sunshine started"

end