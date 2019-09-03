{ config, pkgs, lib, ... }: with lib;
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  /* Automatically hide the mouse cursor after being idle. */
  services.unclutter = {
    enable = true;
    keystroke = true;
  };

  /* Allows smartcards (yubikeys). */
  hardware.u2f.enable = mkForce true;
  services.pcscd.enable = mkForce true;

  /* enable desktop config bus (dconf) */
  programs.dconf.enable = true;

}; }
