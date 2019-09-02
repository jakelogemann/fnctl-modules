{ config, lib, pkgs, options, ... }:
with lib;
with (import ./_helpers.nix {inherit config pkgs lib;});
let
  inherit (config.fnctl2) gui;
  inherit (config.fnctl2.gui.i3wm) colors defaultFont defaultFontSize;
in {
  config.environment.etc."i3/Xresources" = lib.mkIf (isEnabled config) {
    text = (lib.concatStringsSep "\n" [
      "! System-wide I3 Xresources configuration"
    ]);
  };
}
