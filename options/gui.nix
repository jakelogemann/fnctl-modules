{ config, lib, options, pkgs, ... }: 
{ options.fnctl2.gui = with lib; {

  enable = mkEnableOption "Enable opinionated Gnome desktop environment.";

  defaultApps = {

    browser = mkOption 
    { description = "Which browser should be pre-configured as the default?";
      default = "firefox";
      type = types.enum 
      [ "firefox"
        "chromium"
        "google-chrome"
        "qutebrowser"
      ];
    };

    editor = mkOption 
    { description = "Which graphical editor should be pre-configured as the default?";
      default = "vscode";
      type = types.enum 
      [ "vscode"
        "neovim"  /* Implemented w/ alacritty term */
      ];
    };

    terminal = mkOption 
    { description = "Which graphical terminal should be pre-configured as the default?";
      default = "kitty";
      type = types.enum [ 
        "kitty" 
        "alacritty" 
      ];
    };

  }; /* </defaultApps> */

}; } /* </gui options> */

