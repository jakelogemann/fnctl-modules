{ config, lib, options, pkgs, ... }: {

  imports = [
    ./boot-sysctl.nix
    ./boot.nix
    ./firewall.nix
    ./locale.nix
    ./nix-config.nix
    ./processes.nix
    ./ssh.nix
    ./systemPackages.nix
    ./virtualisation.nix
  ];

}
