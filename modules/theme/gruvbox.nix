{ pkgs, ... }:

{

  environment.variables = {
    GTK_THEME = "Gruvbox-Dark-Brown";
    ADW_DISABLE_PORTAL = "0";
    XCURSOR_THEME = "Nordzy-cursors";
  };

  environment.variables.XCURSOR_SIZE = "24";
  environment.variables.HYPRCURSOR_THEME = "Nordzy-cursors";
  environment.variables.HYPRCURSOR_SIZE = "24";

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  console = {
    earlySetup = true;
    colors = [
      "282828" # bg
      "cc241d" # red
      "98971a" # green
      "d79921" # yellow
      "458588" # blue
      "b16286" # purple
      "689d6a" # aqua
      "a89984" # fg4
      "928374" # bg4
      "fb4934" # bright red
      "b8bb26" # bright green
      "fabd2f" # bright yellow
      "83a598" # bright blue
      "d3869b" # bright purple
      "8ec07c" # bright aqua
      "ebdbb2" # fg
    ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gruvbox-dark-gtk
    gruvbox-plus-icons
    nordzy-cursor-theme
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
  ];
}
