# This is for moonlight, the client for sunshine so I can game remotely
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];
}
