{ config, lib, pkgs, options, ... }:

with lib;
with (import ./_helpers.nix {inherit config pkgs lib;});

{
  imports = [
    ./dunst.nix
    ./i3_config.nix
    ./i3_status.nix
    ./fonts.nix
    ./xresources.nix
    ./rofi-config.nix
    ./rofi-theme.nix
  ];

  config = mkIf (isEnabled config) {
    services.xserver.windowManager.i3 = mkForce {
      enable = true;
      configFile = "/etc/i3/config";
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        alacritty
        arandr
        desktop-file-utils
        dmenu
        i3-gaps
        i3status
        dunst
        maim
        qutebrowser
        kitty
        rofi
        rofi-menugen
        rofi-pass
        rofi-systemd
        libnotify
        compton
        sxiv
        feh
        zathura
        redshift
        scrot
        slock
        wmctrl
        xclip
        xdg-user-dirs
        xdg_utils
        xdo
        xdotool
        xsel
      ];
    };
  };

}

