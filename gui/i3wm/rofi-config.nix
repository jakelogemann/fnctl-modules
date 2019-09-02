{ config, lib, pkgs, options, ... }:
with lib;
with (import ./_helpers.nix {inherit config pkgs lib;});
let
  inherit (config.fnctl2) gui;
  inherit (config.fnctl2.gui.i3wm) colors defaultFont defaultFontSize;
in {
  config = lib.mkIf (isEnabled config) {

    environment.etc."i3/rofi-config.rasi" = {
      text = builtins.readFile ./rofi-config.rasi;
    };

  };
}
