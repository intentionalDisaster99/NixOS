# This is for moonlight, the client for sunshine so I can game remotely
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
}
