{ config, lib, options, pkgs, ... }: {

  imports = [
    ./boot-sysctl.nix
    ./boot.nix
    ./firewall.nix
    ./hardware.nix
    ./locale.nix
    ./nix-config.nix
    ./processes.nix
    ./ssh.nix
    ./systemPackages.nix
    ./virtualisation.nix
  ];

}
