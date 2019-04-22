{ config, pkgs, lib, ... }: with lib;
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  gtk.iconCache.enable = mkDefault true;
  services.xserver.desktopManager.gnome3 = mkForce {
    enable = true;
  };

}; }
