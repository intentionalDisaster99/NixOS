# I know, huge file. I just wanted to make it scalable in the future if needed

{ ... }:

{
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;
}   