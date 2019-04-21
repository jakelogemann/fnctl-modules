{ config, lib, options, pkgs, ... }: 
{ options.fnctl2.gui = with lib; {

  enable = mkEnableOption "Enable opinionated Gnome desktop environment.";

}; }
