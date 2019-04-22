{ config, lib, options, pkgs, ... }: 
{ options.fnctl2.gui = with lib; {

  enable = mkEnableOption "Enable opinionated Gnome desktop environment.";

  defaultApps = {

    browser = mkOption 
    { description = "Which browser should be pre-configured as the default?";
      default = "firefox";
      type = types.enum 
      [ "firefox"
        "chromium-browser"
        "google-chrome"
        "qutebrowser"
      ];
    };

    editor = mkOption 
    { description = "Which graphical editor should be pre-configured as the default?";
      default = "code";
      type = types.enum 
      [ "code"
        "nvim"  /* Implemented w/ alacritty term */
      ];
    };

    terminal = mkOption 
    { description = "Which graphical terminal should be pre-configured as the default?";
      default = "alacritty";
      type = types.enum [ 
        "alacritty" 
        "kitty" 
      ];
    };

  }; /* </defaultApps> */

}; } /* </gui options> */

