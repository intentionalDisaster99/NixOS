function windows
    # 1. Queue up Windows for the next boot in GRUB
    sudo grub-reboot 1
    
    # 2. Tell the kernel's power management to reboot after saving state
    echo "reboot" | sudo tee /sys/power/disk > /dev/null
    
    # 3. Trigger hibernation directly via the kernel
    echo "disk" | sudo tee /sys/power/state > /dev/null
end