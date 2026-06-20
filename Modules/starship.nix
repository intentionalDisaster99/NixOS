# Enables starship, a cool prompt for shells
# It works for all shells, so I separated it from my fish in case I wanted to switch

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    # TODO Update these to look nicer (these are from a starship tutorial I found)
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };

  };
}
