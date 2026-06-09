{ pkgs, inputs, ... }:
{
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  # install package
  environment.systemPackages = with pkgs; [
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.kdePackages.wrapQtAppsHook ];
      buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ pkgs.kdePackages.kirigami ];
    }))
  ];
}
