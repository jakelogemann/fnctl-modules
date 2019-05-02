{ config, pkgs, lib, ... }: with lib;
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  /* Automatically hide the mouse cursor after being idle. */
  services.unclutter = {
    enable = true;
    keystroke = true;
  };

  programs.dconf.enable = true;

}; }
