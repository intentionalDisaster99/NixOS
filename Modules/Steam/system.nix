# Allows steam to be used for gaming (must be a system module because of the graphics stuff)
{ config, pkgs, ... }:

hardware.graphics = {
enable = true;
enable32Bit = true;
};

programs.steam = {
enable = true;

remotePlay.openFirewall = true;
dedicatedServer.openFirewall = true;
};

environment.systemPackages = with pkgs; [
steam
steam-run
];
}
