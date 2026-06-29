function workspace_router
    set action $argv[1]
    set num $argv[2]

    # Grab the active monitor name natively from Hyprland
    set active_mon (hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

    # Apply the block offset
    switch $active_mon
        case "eDP-1"
            set offset 0
        case "DP-1"
            set offset 10
        case "HDMI-A-1"
            set offset 20
        case "DP-3"
            set offset 30
        case "HEADLESS-1"
            set offset 40
        case '*'
            set offset 0
    end

    set target (math $offset + $num)

if test "$action" = "focus"
        # hyprctl dispatch "\"workspace\", \"$target\""
        hyprctl eval 'hl.dispatch(hl.dsp.focus({ workspace = "'$target'" }))'
    else if test "$action" = "move"
        # hyprctl dispatch "\"movetoworkspace\", \"$target\""
        hyprctl eval 'hl.dispatch(hl.dsp.window.move({ workspace = "'$target'" }))'
    endp
end
