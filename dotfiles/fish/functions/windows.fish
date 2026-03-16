function windows
    # Queue up Windows for the next boot
    sudo grub-reboot 1
    
    # Temporarily set systemd to reboot after hibernating
    sudo mkdir -p /etc/systemd/sleep.conf.d
    printf "[Sleep]\nHibernateMode=reboot\n" | sudo tee /etc/systemd/sleep.conf.d/hibernate-reboot.conf > /dev/null
    
    # Trigger hibernation
    sudo systemctl hibernate
    
    # Clean up the config immediately when Linux wakes back up
    sudo rm -f /etc/systemd/sleep.conf.d/hibernate-reboot.conf
end