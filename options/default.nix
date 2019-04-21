{ config, lib, options, pkgs, ... }: with lib; {

  options.fnctl2 = {
    enable = mkEnableOption "Enable the FnCtl modules.";
  };

  imports = [
    ./networking.nix
    ./programs.nix
    ./gui.nix
  ];

}
