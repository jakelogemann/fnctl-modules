{ config, lib, options, pkgs, ... }:

let
  inherit (lib) mkOption types;
in {
  options.fnctl2.gui.i3wm = with lib; {

    enable = mkOption {
      description = "Enable opinionated I3 environment(s).";
      default = true;
      type = types.bool;
    };

    defaultFont = mkOption {
      default = "FuraCode Nerd Font Mono";
      description = "Default font to use for i3 (preferably monospace with patched icons).";
      type = types.str;
    };

    defaultFontSize = mkOption {
      default = "12";
      description = "Default font to use for i3 (preferably monospace with patched icons).";
      type = types.str;
    };

    extraStartupCommands = mkOption {
      description = "Extra commands to 'exec_always' in i3wm.";
      type = with types; listOf str;
      default = [];
    };

    defaultMonitor = mkOption {
      default = "eDP-1";
      description = "Default xrandr output to set upon i3 restart.";
      type = types.str;
    };

    colors =
    let
      colorOption = ident: default: mkOption {
        inherit default;
        description = "Hexadecimal 256-color code for ${ident} (without leading #).";
        type = types.str;
      };
    in {
      bg = colorOption "bg" "222222";
      fg = colorOption "fg" "EAEAEA";
      bright    = {
        black   = colorOption "bright black"   "161616";
        red     = colorOption "bright red"     "e84f4f";
        green   = colorOption "bright green"   "b7ce42";
        yellow  = colorOption "bright yellow"  "fea63c";
        blue    = colorOption "bright blue"    "66aabb";
        magenta = colorOption "bright magenta" "b7416e";
        cyan    = colorOption "bright cyan"    "6d878d";
        white   = colorOption "bright white"   "dddddd";
      };
      normal    = {
        black   = colorOption "black"   "666666";
        red     = colorOption "red"     "d23d3d";
        green   = colorOption "green"   "bde077";
        yellow  = colorOption "yellow"  "ffe863";
        blue    = colorOption "blue"    "aaccbb";
        magenta = colorOption "magenta" "e16a98";
        cyan    = colorOption "cyan"    "42717b";
        white   = colorOption "white"   "cccccc";
      };
    };

  };
}
