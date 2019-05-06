{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable dev;

in { config = mkIf (enable && dev.enable && dev.docker.enable) {

  # Docker
  virtualisation = {
    docker.enable = lib.mkForce true;
  };

  environment.systemPackages = (with pkgs; [
    docker # An open source project to pack, ship and run any application as a lightweight container
  ]);
}; }
