{ config, lib, options, pkgs, ... }:
{ options.fnctl2.gui = with lib; {

  enable = mkOption {
    description = "Enable opinionated desktop environment(s).";
    default = true;
    type = types.bool;
  };

  defaultApps = {

    browser = mkOption {
      description = "Which browser should be pre-configured as the default?";
      default = "firefox";
      type = types.enum
      [ "firefox"
        "chromium-browser"
        "google-chrome"
        "qutebrowser"
      ];
    };

    editor = mkOption {
      description = "Which graphical editor should be pre-configured as the default?";
      default = "code";
      type = types.enum
      [ "code"
        "nvim"  /* Implemented w/ default term */
        "gnvim"
      ];
    };

    terminal = mkOption {
      description = "Which graphical terminal should be pre-configured as the default?";
      default = "alacritty";
      type = types.enum [
        "alacritty"
        "kitty"
      ];
    };

  }; /* </defaultApps> */

}; } /* </gui options> */
