{ config, pkgs, lib, ... }:

{

  programs.bash.shellAliases = {
    cd = "z";
    nrs = "/etc/nixos/scripts/nrs.sh";
    windows = "sudo grub-reboot 1 && reboot";
    pioStart = "nix run --impure github:xdadrm/nixos_use_platformio_patformio-ide_and_vscode#codium --";
  };

}
