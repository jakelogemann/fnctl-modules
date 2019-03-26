{ config, lib, options, pkgs, ... }:
{ options.fnctl2 = with lib; {
    enable = mkEnableOption "Enable the FnCtl modules.";
  };

  imports = [
    ./networking.nix
    ./programs.nix
  ];

}
