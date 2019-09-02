{ config, lib, options, pkgs, ... }: {

  imports = [
    ./shells
    ./boot-sysctl.nix
    ./boot.nix
    ./hardware.nix
    ./nix-config.nix
    ./processes.nix
    ./ssh.nix
    ./shell.nix
    ./systemPackages.nix
    ./virtualisation.nix
  ];

}
