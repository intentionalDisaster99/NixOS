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
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

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

    extraConfig = ''
      set gfxpayload=text
    '';
  };

  # A splash screen
  boot = {
    plymouth = {
      enable = true;
      # theme = "rings";
      # themePackages = with pkgs; [
      #   # By default we would install all themes
      #   (adi1090x-plymouth-themes.override {
      #     selected_themes = [ "rings" ];
      #   })
      # ];
    };
    # initrd.supportedFilesystems.ext4 = true;
    initrd.systemd.enable = true;
    # Enable "Silent boot"
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "vt.global_cursor_default=0"
    ];

    # You can still access the loader but you just have to press a key
    loader.timeout = 0;

  };

}
