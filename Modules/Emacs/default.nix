home-manager.users.${username} = { config, lib, pkgs, ... }:
let
doomBootstrap = pkgs.writeShellScript "doom-bootstrap" ''
    set -eu
    EMACSDIR="$HOME/.config/emacs"

    # No network yet? Exit non-zero so systemd retries later.
    git ls-remote -q https://github.com/doomemacs/doomemacs HEAD >/dev/null 2>&1 || exit 1

    [ -d "$EMACSDIR" ] || git clone --depth 1 https://github.com/doomemacs/doomemacs "$EMACSDIR"
    "$EMACSDIR/bin/doom" install --force --no-fonts
  '';
in
{
fonts.packages = with pkgs; [
source-code-pro
nerd-fonts.symbols-only
];

home-manager.users.${username} = { ... }: {
home.packages = with pkgs; [
emacs-pgtk
git ripgrep fd coreutils ispell
gcc gnumake cmake libtool
asm-lsp qemu
(texlive.combine {
inherit (texlive) scheme-small dvisvgm preview dvipng cm-super type1cm;
})
];
};

# Linking to dots
xdg.configFile."doom".source =
config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Emacs/Doom";

# A systemd thing to install doom if it isn't already
systemd.user.services.doom-bootstrap = {
Unit = {
Description = "Install Doom Emacs if it's missing";
ConditionPathExists = "!%h/.config/emacs/.local";
StartLimitIntervalSec = 0;
};
Service = {
Type = "oneshot";
Environment = [
"PATH=${lib.makeBinPath (with pkgs; [
git emacs-pgtk ripgrep fd coreutils bash
gnumake gcc cmake libtool gnused gnugrep findutils gawk
])}"
];
ExecStart = "${doomBootstrap}";
Restart = "on-failure";
RestartSec = "60";
};
Install.WantedBy = [ "default.target" ];
};
}
