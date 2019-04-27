{ config, lib, options, pkgs, ... }:
{ options.fnctl2.gui = with lib; {

  enable = mkEnableOption "Enable opinionated Gnome desktop environment.";

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

    gnomeExtensions = mkOption {
      description = "Which GNOME extensions should be enabled (by UUID)?";
      default = [
        "arc-menu@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "dash-to-panel@jderose9.github.com"
        "impatience@gfxmonk.net"
        "nohotcorner@azuri.free.fr"
        "system-monitor@paradoxxx.zero.gmail.com"
        "ShellTile@emasab.it"
        "TopIcons@phocean.net"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      type = types.listOf (types.enum [
        "arc-menu@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "dash-to-panel@jderose9.github.com"
        "impatience@gfxmonk.net"
        "nohotcorner@azuri.free.fr"
        "system-monitor@paradoxxx.zero.gmail.com"
        "ShellTile@emasab.it"
        "tilingnome@rliang.github.com"
        "TopIcons@phocean.net"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "workspace-grid@mathematical.coffee.gmail.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ]);
    };

  }; /* </defaultApps> */

}; } /* </gui options> */
