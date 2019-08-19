{ config, lib, options, pkgs, ... }: {

  imports = [
    ./boot-sysctl.nix
    ./boot.nix
    ./hardware.nix
    ./locale.nix
    ./nix-config.nix
    ./processes.nix
    ./ssh.nix
    ./shell.nix
    ./systemPackages.nix
    ./virtualisation.nix
  ];

}
