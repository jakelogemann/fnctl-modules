{ config, pkgs, lib, ... }: with lib;

{ config.fonts = mkIf (with config.fnctl2; enable && gui.enable) {
  enableDefaultFonts = false;
  enableFontDir      = false;

  fontconfig = {
    enable = true;
    defaultFonts.monospace = ["FuraCode Nerd Font Mono"];
    defaultFonts.sansSerif = ["FuraCode Nerd Font"];
    defaultFonts.serif     = ["FuraCode Nerd Font"];
  };
  fonts = with pkgs; [
    nerdfonts
    emojione
  ];
}; }
