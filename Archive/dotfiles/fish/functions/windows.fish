# This currently does not work, but I am not giving up on it

function windows1
    # Queue up Windows for the next boot in GRUB
    sudo grub-reboot 1
    
    # Tell the kernel's power management to reboot after saving state
    echo "reboot" | sudo tee /sys/power/disk > /dev/null
    
    # Trigger hibernation directly via the kernel
    echo "disk" | sudo tee /sys/power/state > /dev/null
end