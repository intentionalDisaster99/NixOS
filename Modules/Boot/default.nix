# Controls the bootloader that I use (Grub)

{ config
, pkgs
, lib
, inputs
, ...
}:

{
  imports = [
    inputs.minegrub-world-sel-theme.nixosModules.default
  ];
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  # Teehee silly sddm
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "minesddm";
  #   wayland.enable = true;
  # };
  environment.systemPackages = with pkgs; [
    # Add the required Qt dependencies
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
  ];

  # Actually turning the bad boi on
  boot.loader.grub = {
    enable = true;
    useOSProber = true;

    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "NixOS ${config.system.nixos.distroName}";
          lineBottom = "The right choice";
          imgName = "nixos";
        }
      ];
    };
  };

  # A splash screen
  boot = {
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };
    # Enable "Silent boot"
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    # loader.timeout = 0;
  };

}
