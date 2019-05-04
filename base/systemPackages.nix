{ config, lib, options, pkgs, ... }:

lib.mkIf config.fnctl2.enable {

  programs.bash = {
    enableCompletion = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    cacert
    lshw
  ];
}
