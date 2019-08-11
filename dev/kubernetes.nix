{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable dev;

in { 
  config = mkIf (enable && dev.enable && dev.kubernetes.enable) {
    environment.systemPackages = [ pkgs.fnctlPkgs.ext.kubernetes ];
  }; 
}
