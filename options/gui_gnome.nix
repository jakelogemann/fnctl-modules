{ config, lib, options, pkgs, ... }:
{ options.fnctl2.gui.gnome = with lib; {

  enable = mkOption {
    description = "Enable opinionated Gnome3 environment(s).";
    default = true;
    type = types.bool;
  };

  extensions = mkOption {
    description = "Which GNOME extensions should be enabled (by UUID)?";
    default = [
      "arc-menu@gnome-shell-extensions.gcampax.github.com"
      "appindicatorsupport@rgcjonas.gmail.com"
      "caffeine@patapon.info"
      "dash-to-panel@jderose9.github.com"
      "impatience@gfxmonk.net"
      "lockkeys@vaina.lt"
      "nohotcorner@azuri.free.fr"
      "passwordstore@mcat95.gmail.com"
      "system-monitor@paradoxxx.zero.gmail.com"
      "ShellTile@emasab.it"
      "scriptexec@samb1999.hotmail.co.uk"
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
      "lockkeys@vaina.lt"
      "nohotcorner@azuri.free.fr"
      "passwordstore@mcat95.gmail.com"
      "system-monitor@paradoxxx.zero.gmail.com"
      "ShellTile@emasab.it"
      "scriptexec@samb1999.hotmail.co.uk"
      "TopIcons@phocean.net"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
      "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
    ]);
  };

  theme = mkOption {
    description = "Theme used in GNOME.";
    default = "Nordic";
    type = types.enum [
      "Adwaita"
      "Adwaita-dark"
      "Emacs"
      "HighContrast"
      "Nordic"
      "Nordic-blue"
      "Nordic-blue-standard-buttons"
      "Nordic-standard-buttons"
    ];
  };

  dconfOverrides = mkOption {
    description = "dconf settings to apply last, adding to or overriding defaults.";
    default = {};
    type = types.attrs;
  };

}; } /* </gnome options> */
