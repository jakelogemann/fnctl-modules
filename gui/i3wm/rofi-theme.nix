{ config, lib, pkgs, options, ... }:
with lib;
with (import ./_helpers.nix {inherit config pkgs lib;});
let
  inherit (config.fnctl2) gui;
  inherit (config.fnctl2.gui.i3wm) colors defaultFont defaultFontSize;
in { 
  config= lib.mkIf (isEnabled config) {
    environment.etc."i3/rofi-theme.rasi" = {
      text = ''
        * {
          accent:           #83a598;
          background:       #282828;
          background-light: #282828;
          background-focus: #1d2021;
          foreground:       #ebdbb2;
          foreground-list:  #ebdbb2;
          on:               #83a598;
          off:              #fb4934;
        }
      '';
    };
}; }
