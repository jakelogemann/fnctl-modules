{ config, lib, pkgs, ... }: with lib;
{
  imports = [
    ./packages.nix
    ./services.nix
    ./dconf.nix
    ./app-folders.nix
  ];

  config = mkIf (with config.fnctl2; gui.enable && gui.gnome.enable) {

    gtk.iconCache.enable = mkDefault true;

    services.xserver.desktopManager.gnome3 = mkForce {
      enable = true;
    };

  };
}

