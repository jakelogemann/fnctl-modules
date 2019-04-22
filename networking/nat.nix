{ config, lib, pkgs, ... }: with lib;

let
  isEnabled = (with config.fnctl2; enable);

in { config = lib.mkIf isEnabled {
  networking.nat = {
    enable = true;
    internalIPs = [ "127.0.0.0/8" ];
    internalInterfaces = [
      "ve-+"
      "vb-+"
      "vbox+"
      "virbr0"
      "docker0"
    ];
  };
}; }

