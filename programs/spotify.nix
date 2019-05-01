{ config, lib, options, pkgs, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.spotify.enable);
  hasGui = config.services.xserver.enable;

  /* spotifyPackages are always installed, system-wide. */
  spotifyPackages = lib.optionals hasGui (with pkgs; [ ]);

  /* spotifyGuiPackages are only installed if X11 is enabled. */
  spotifyGuiPackages = lib.optionals hasGui (with pkgs; [
    spotify
  ]);

in {
  config.environment = lib.mkIf isEnabled {
    systemPackages = spotifyPackages ++ spotifyGuiPackages;
 };
}
