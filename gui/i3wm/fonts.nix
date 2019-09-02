{ config, pkgs, lib, ... }:

with lib;
with (import ./_helpers.nix {inherit config pkgs lib;});

{ config = mkIf (isEnabled config) {
  # environment.variables."TERM" = mkForce "alacritty";
  fonts = mkForce {
    enableDefaultFonts = false;
    enableFontDir      = false;

    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["FuraCode Nerd Font Mono"];
      defaultFonts.sansSerif = ["FuraCode Nerd Font"];
      defaultFonts.serif     = ["FuraCode Nerd Font"];
    };

    fonts = with pkgs; [
      emojione              # emoji
      nerdfonts             # patched developer targeted and/or used fonts as possible
    ];
  };

}; }
