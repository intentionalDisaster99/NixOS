# AI generated gnome thing so that I can try it out

{ config, pkgs, ... }:

{
  # Enable the X11 windowing system (required as a base for GDM)
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment and GDM
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Optional: Remove GNOME bloatware you probably won't use
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany # web browser
    geary # email reader
    evince # document viewer
    totem # video player
  ];

  # Ensure you still have a way to easily open a terminal!
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    kitty # Keeping your preferred terminal available
  ];
}
