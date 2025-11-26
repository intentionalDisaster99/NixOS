function power_save_toggle
    # Check if blur is currently enabled (1) or disabled (0)
    set current_state (hyprctl getoption decoration:blur:enabled | awk '/int:/ {print $2}')

    if test "$current_state" -eq 1
        # --- ACTIVATE LOW POWER MODE ---
        # Turn off Blur, Shadows, and Animations to save GPU
        hyprctl --batch "\
            keyword decoration:blur:enabled 0;\
            keyword decoration:shadow:enabled 0;\
            keyword animations:enabled 0"
        
        # Tell the system to save power (CPU throttling)
        powerprofilesctl set power-saver
        
        notify-send -u low "🔋 Eco Mode Enabled" "Visual effects off, CPU throttled."
    else
        # --- RESTORE NORMAL MODE ---
        # Turn effects back on
        hyprctl --batch "\
            keyword decoration:blur:enabled 1;\
            keyword decoration:shadow:enabled 1;\
            keyword animations:enabled 1"
        
        # Return to balanced power profile
        powerprofilesctl set balanced
        
        notify-send -u low "⚡ Performance Restored" "Visual effects enabled."
    end
end